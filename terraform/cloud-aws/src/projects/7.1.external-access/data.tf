locals {
  target_vault_http_object_sequence_number = "002"
  count_enable_k8s_istio                         = var.enable_k8s_istio ? 1 : 0
  count_enable_k8s_security                      = var.enable_k8s_security && var.vault_enable_public ? 1 : 0
}

data "aws_region" "current" {
}

data "aws_vpc" "primary" {
  tags = {
    Name = "${module.naming_convention.basenamevpc}${module.naming_convention.default_object_sequence_number}"
  }
}

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "main" {
  name = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
}

data "aws_eks_cluster_auth" "main_cluster_auth" {
  name = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
}

data "kubernetes_service" "istio-ingressgateway" {
  count = local.count_enable_k8s_istio
  metadata {
    name      = "istio-ingressgateway"
    namespace = "istio-system"
  }
}

data "kubernetes_service" "vault_ingress" {
  count = local.count_enable_k8s_security
  metadata {
    name      = "${var.default_tags["_Application"]}-eks-vault-${var.default_tags["_Environment"]}-ui"
    namespace = "addons"
  }
}

data "aws_lb_target_group" "http" {
  name = "${module.naming_convention.basenamenlb}${module.naming_convention.default_object_sequence_number}-http"
}

data "aws_lb_target_group" "https" {
  name = "${module.naming_convention.basenamenlb}${module.naming_convention.default_object_sequence_number}-https"
}

data "dns_a_record_set" "istio_ingress" {
  host = data.kubernetes_service.istio-ingressgateway.0.status.0.load_balancer.0.ingress.0.hostname
  count = local.count_enable_k8s_istio
}

data "dns_a_record_set" "vault_ingress" {
  host = data.kubernetes_service.vault_ingress.0.status.0.load_balancer.0.ingress.0.hostname
   
  count = local.count_enable_k8s_security
}

data "aws_lb" "selected" {
  name = "${module.naming_convention.basenamenlb}${module.naming_convention.default_object_sequence_number}"
}

data "aws_lb_listener" "selected443" {
  load_balancer_arn = data.aws_lb.selected.arn
  port              = 443
}

data "aws_route53_zone" "environment_subdomain" {
  name         = "blue1sky.me."
}