locals {
  enable_service      = var.enable_cicd ? 1 : 0
}

data "template_file" "helm_sonar" {
  count = local.enable_service

  template = file("${path.module}/templates/services.yaml")

  vars = {
    INFRA_UNIT        = var.default_tags["Infra-Unit"]
    ENV               = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    RESOURCE          = var.default_tags["_Application"]
  }
}