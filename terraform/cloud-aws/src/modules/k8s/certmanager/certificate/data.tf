###############################################################################
##### K8S Security ############################################################
###############################################################################
locals {
  count_k8s_security = var.enable_k8s_security ? 1 : 0
}

data "aws_region" "current" {
  count = local.count_k8s_security
}

data "aws_caller_identity" "current" {
  count = local.count_k8s_security
}