###############################################################################
##### NAMING CONVENTION CONFIGURATION IMPORT ##################################
###############################################################################

module "naming_convention" {
  source                       = "../naming-convention"
  region                       = var.region
  entity                       = var.default_tags["_Entity"]
  environment                  = var.default_tags["_Environment"]
  geo_region                   = var.default_tags["_GeoRegion"]
  application                  = var.default_tags["_Application"]
  naming_convention_definition = var.naming_convention_definition
}

###############################################################################
###############################################################################
###############################################################################

module "ec2-key-pair-globile" {
  source = "../m-sec/key-pair"
  name   = "${var.default_tags["_Application"]}-vpn-key-${var.default_tags["_Environment"]}"
  path = "../../../../envs/${var.env_folder_name}/vpn-ssh-${var.default_tags["_Environment"]}.pub"
}

module "sg_mgmt_ssh" {
  source          = "../m-sec/group/egress"
  vpc_id          =   data.aws_vpc.primary.id
  es_access_cidr  =   ["0.0.0.0/0"]
  object_sequence =   var.sg_mgmt_ssh_object_sequence

  from_port       =   "0"
  to_port         =   "0"
  protocol        =   "-1"
  default_tags    =   merge(
                        tomap({
                          "Scope"="Access ssh/https"
                         } ),
                        "${var.default_tags}"
                        )
  basenamesgr     = module.naming_convention.basenamesgr
}

module "sg_rule_w_access_from_intener_22" {
  source                    = "../m-sec/group/rule/block"
  from_port                 = "22"
  to_port                   = "22"
  protocol                  = "tcp"
  rule_type                 = "ingress"
  security_group_id         = module.sg_mgmt_ssh.id
  #source_security_group_id  = "${module.sg_mgmt_ssh.id}"
  es_access_cidr               = ["0.0.0.0/0"]
  description               = "Allow access ssh from internet"
}

module "sg_rule_w_access_from_intener_1194" {
  source                    = "../m-sec/group/rule/block"
  from_port                 = "1194"
  to_port                   = "1194"
  protocol                  = "udp"
  rule_type                 = "ingress"
  security_group_id         = module.sg_mgmt_ssh.id
  #source_security_group_id  = "${module.sg_mgmt_ssh.id}"
  es_access_cidr               = ["0.0.0.0/0"]
  description               = "Allow access https from internet"
}

module "create_server_file" {
  source                 = "../utils/create-file-from-template"
  destination_file_path  = "templates/server_rendered.conf"
  source_template        = "templates/server.conf"
  template_vars          = {
    DNS = var.mgmt_pfsense_dns_ip
  }
}
resource "aws_instance" "web" {
  ami           = var.mgmt_pfsense_image_id
  instance_type = "t2.micro"

  key_name      = module.ec2-key-pair-globile.key_name

  depends_on = [
    module.create_server_file.rendered_file
  ]

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("templates/vpn.pem")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "templates/server_rendered.conf"
    destination = "/tmp/server.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/server.conf /etc/openvpn/server.conf",
      "sudo systemctl restart openvpn@server.service"
    ]
  }
  tags = merge(
  {
    Name = "${var.default_tags["_Application"]}-${var.az_dns_vpn}-${var.default_tags["_Environment"]}",
    Service = "Security"
  },
  "${var.default_tags}"
  )
}

resource "aws_network_interface" "foo" {
  subnet_id   = data.aws_subnet.subnet.id
  #private_ips = ["172.16.10.100"]
  security_groups = [module.sg_mgmt_ssh.id]

  tags = {
    Name = "${var.default_tags["_Application"]}-${var.az_dns_vpn}-${var.default_tags["_Environment"]}_eth"
  }
}

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.foo.id
  associate_with_private_ip = tolist(aws_network_interface.foo.private_ips)[0]
}

###Internal CNAMe
module "cname_entry"{
  source    = "../m-route53-entry-cname"
  zone_id   = data.aws_route53_zone.zone.id
  new_name  = var.az_dns_vpn
  records   = aws_eip.one.private_dns
  extra     = aws_instance.web.id

}

module  "dns-public-cname" {
  source  = "../../modules/m-route53-entry-cname"
  zone_id = data.aws_route53_zone.public.id
  new_name    = "${var.az_dns_vpn}-${var.default_tags["Infra-Unit"]}.poc"

  records = aws_eip.one.public_dns
}

