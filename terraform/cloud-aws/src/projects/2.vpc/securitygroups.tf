###############################################################################
##### SECURITY GROUPS CONFIGS #################################################
###############################################################################
module "sg_lb_nginx" {
  source          = "../../modules/m-sec/group/egress"
  vpc_id          = module.vpc.vpc_id
  es_access_cidr  = ["0.0.0.0/0"]
  object_sequence = module.naming_convention.default_object_sequence_number

  from_port       = "0"
  to_port         = "0"
  protocol        = "-1"
  default_tags    = var.default_tags
  basenamesgr     = module.naming_convention.basenamesgr
}

module "sg_lb_nginx_from_intener_443" {
  source            = "../../modules/m-sec/group/rule/block"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  rule_type         = "ingress"
  security_group_id = module.sg_lb_nginx.id

  #source_security_group_id  = "${module.sg_mgmt_ssh.id}"
  es_access_cidr = ["0.0.0.0/0"]
  description    = "Allow access https from internet"
}

module "sg_lb_nginx_from_intener_80" {
  source            = "../../modules/m-sec/group/rule/block"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  rule_type         = "ingress"
  security_group_id = module.sg_lb_nginx.id

  #source_security_group_id  = "${module.sg_mgmt_ssh.id}"
  es_access_cidr = ["0.0.0.0/0"]
  description    = "Allow access https from internet"
}

################################################
################################################
