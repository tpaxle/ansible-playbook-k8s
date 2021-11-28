locals {
  count_k8s_elk       = var.enable_k8s_elk ? 1 : 0
  istio_template_name = var.enable_k8s_istio ? "" : ""
}