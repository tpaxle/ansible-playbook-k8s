data "aws_vpc" "primary" {
  tags = {
    Name = "${module.naming_convention.basenamevpc}${module.naming_convention.default_object_sequence_number}"
  }
}

data "aws_subnet" "subnet" {
  vpc_id = "${data.aws_vpc.primary.id}"

  filter {
    name   = "tag:Name"
    values = ["${module.naming_convention.basenamesnt}${module.naming_convention.default_object_sequence_number}-${var.subnet_zone_id}"] # insert value here
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "zone" {
  name         = "${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}."
  private_zone = true
}

data "template_file" "openvpn" {
  template = "${file("templates/openvpn_profile.ovpn")}"

  vars = {
    URL       = "${aws_eip.one.public_dns}"
  }
}
