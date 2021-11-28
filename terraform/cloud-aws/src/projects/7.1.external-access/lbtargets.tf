###############################################################################
##### NAMING CONVENTION CONFIGURATION IMPORT ##################################
###############################################################################

module "naming_convention" {
  source                       = "../../modules/naming-convention"
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

resource "aws_lb_target_group_attachment" "tg_http" {
  count            = (local.count_enable_k8s_istio == 0) ? 0 : length(data.dns_a_record_set.istio_ingress[0].addrs)
  target_group_arn = data.aws_lb_target_group.http.arn
  target_id        = data.dns_a_record_set.istio_ingress[0].addrs[count.index]
  port             = 80
  # depends_on        =   ["time_sleep.wait_30_seconds"]
}

resource "aws_lb_target_group_attachment" "tg_https" {
  count            = (local.count_enable_k8s_istio == 0) ? 0 : length(data.dns_a_record_set.istio_ingress[0].addrs)
  target_group_arn = data.aws_lb_target_group.https.arn
  target_id        = data.dns_a_record_set.istio_ingress[0].addrs[count.index]
  port             = 443
  #depends_on        =   ["time_sleep.wait_30_seconds"]
}

###############################################################################
######LB  Vault
###############################################################################
resource "aws_lb_target_group" "target_vault_http" {
  count       = local.count_enable_k8s_security
  name        = "${module.naming_convention.basenamenlb}${local.target_vault_http_object_sequence_number}-http"
  port        = 8200
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.primary.id
  health_check {
    path = "/ui/"
  }
}

resource "aws_lb_target_group_attachment" "tg_vault_http" {
  count            = (local.count_enable_k8s_security == 0) ? 0 : length(data.dns_a_record_set.vault_ingress[0].addrs)
  target_group_arn = aws_lb_target_group.target_vault_http[0].arn
  target_id        = data.dns_a_record_set.vault_ingress[0].addrs[count.index]
  port             = 8200
  # depends_on        =   ["time_sleep.wait_30_seconds"]
}


#module "cname_vault_access"{
#  source                  = "../../../modules-azure/m-dns-cname"
#  az_dns_name             = var.az_dns_name
#  az_rg_name              = var.az_rg_name
#  dns_name                = "${var.az_dns_vault}.${var.default_tags["Infra-Unit"]}"
#  dns_targed_name         = data.aws_lb.selected.dns_name
#  enable_dns_cname_record = var.enable_k8s_security
#}

###############################################################################


resource "aws_lb_listener_rule" "apiredirect" {
  listener_arn = data.aws_lb_listener.selected443.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.http.arn
  }

  condition {
    host_header {
      values = ["${var.api_gw_domain_name}-${var.default_tags["Infra-Unit"]}.${var.root_public_domain}"]
    }
  }
}

resource "aws_lb_listener_rule" "web" {
  listener_arn = data.aws_lb_listener.selected443.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.http.arn
  }

  condition {
    host_header {
      values = ["demo-app-${var.default_tags["Infra-Unit"]}.${var.root_public_domain}"]
    }
  }
}

resource "aws_lb_listener_rule" "sv_istio" {
  count = local.count_enable_k8s_istio
  listener_arn = data.aws_lb_listener.selected443.arn
  priority     = 4

  action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.http.arn
  }

  condition {
    host_header {
      values = ["${var.api_sv_domain_name}-${var.default_tags["Infra-Unit"]}.${var.root_public_domain}"]
    }
  }
}

resource "aws_lb_listener_rule" "listener_vault" {
  count       = local.count_enable_k8s_security

  listener_arn = data.aws_lb_listener.selected443.arn
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_vault_http[0].arn
  }

  condition {
    host_header {
      values = ["${var.az_dns_vault}-${var.default_tags["Infra-Unit"]}.${var.root_public_domain}"]
    }
  }
}





module  "dns-api" {
  source  = "../../modules/m-route53-entry-cname"
  zone_id = data.aws_route53_zone.environment_subdomain.id
  new_name    = "${var.api_sv_domain_name}-${var.default_tags["Infra-Unit"]}"

  records = data.aws_lb.selected.dns_name
}

module  "dns-gw" {
  source  = "../../modules/m-route53-entry-cname"
  zone_id = data.aws_route53_zone.environment_subdomain.id
  new_name    = "${var.api_gw_domain_name}-${var.default_tags["Infra-Unit"]}.poc"

  records = data.aws_lb.selected.dns_name
}

module  "dns-istio" {
  source  = "../../modules/m-route53-entry-cname"
  zone_id = data.aws_route53_zone.environment_subdomain.id
  new_name    = "istio-${var.default_tags["Infra-Unit"]}.poc"

  records = data.aws_lb.selected.dns_name
}

module  "dns-vault" {
  source  = "../../modules/m-route53-entry-cname"
  zone_id = data.aws_route53_zone.environment_subdomain.id
  new_name    = "${var.az_dns_vault}-${var.default_tags["Infra-Unit"]}.poc"

  records = data.aws_lb.selected.dns_name
}

#module "cname_vault_access"{
#  source                  = "../../../modules-azure/m-dns-cname"
#  az_dns_name             = var.az_dns_name
#  az_rg_name              = var.az_rg_name
#  dns_name                = "${var.az_dns_vault}-${var.default_tags["Infra-Unit"]}"
#  dns_targed_name         = data.aws_lb.selected.dns_name
#  enable_dns_cname_record = var.enable_k8s_security
#}

###############################################################################

