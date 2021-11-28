module "k8s-observability" {
  source                                      = "../../modules/k8s/observability"
  default_tags                                = var.default_tags
  region                                      = var.region
  access_key                                  = var.access_key
  secret_key                                  = var.secret_key
  kubernetes_helm_prometheusop_chart_version  = var.kubernetes_helm_prometheusop_chart_version
  kubernetes_helm_prometheusop_chart_name     = var.kubernetes_helm_prometheusop_chart_name
  root_infra_domain                           = var.root_infra_domain
  root_public_domain                          = var.root_public_domain
  enable_k8s_observability                    = var.enable_k8s_istio || var.enable_k8s_observability
  enable_k8s_istio                            = var.enable_k8s_istio
}
