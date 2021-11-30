###############################################################################
##### K8S SERVICES  ###########################################################
###############################################################################


locals {
  count_k8s_observability = var.enable_k8s_observability ? 1 : 0
}


data "template_file" "helm_prometheus" {
  count = local.count_k8s_observability

  template = file("${path.module}/templates/eks_prometheus_exporter.yaml")

  vars = {
    INFRA_UNIT        = var.default_tags["Infra-Unit"]
    ENV               = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    RESOURCE          = var.default_tags["_Application"]
  }
}

data "template_file" "helm_thanos" {
  count = local.count_k8s_observability

  template = file("${path.module}/templates/thanos.yaml")

  vars = {
    INFRA_UNIT        = var.default_tags["Infra-Unit"]
    ENV               = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    RESOURCE          = var.default_tags["_Application"]
    REGION            = var.region
    ACCESSKEY         = var.access_key
    ACCESSPASS        = var.secret_key
  }
}
