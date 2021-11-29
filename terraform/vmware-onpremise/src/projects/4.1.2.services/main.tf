module "k8s-services-helm" {
  source                                        = "../../modules/k8s/services"
  default_tags                                  = var.default_tags
  kubernetes_helm_externaldns_chart_name        = var.kubernetes_helm_externaldns_chart_name
  kubernetes_helm_externaldns_chart_version     = var.kubernetes_helm_externaldns_chart_version
  kubernetes_helm_dashboard_chart_name          = var.kubernetes_helm_dashboard_chart_name
  kubernetes_helm_dashboard_chart_version       = var.kubernetes_helm_dashboard_chart_version
  kubernetes_helm_kube-sm_chart_name            = var.kubernetes_helm_kube-sm_chart_name
  kubernetes_helm_kube-sm_chart_version         = var.kubernetes_helm_kube-sm_chart_version
  kubernetes_helm_metrics-server_chart_name     = var.kubernetes_helm_metrics-server_chart_name
  kubernetes_helm_metrics-server_chart_version  = var.kubernetes_helm_metrics-server_chart_version
  kubernetes_helm_ingress_chart_name            = var.kubernetes_helm_ingress_chart_name
  kubernetes_helm_ingress_chart_version         = var.kubernetes_helm_ingress_chart_version
  root_infra_domain                             = var.root_infra_domain
  region                                        = var.region
  kubernetes_helm_certmanager_chart_version     = var.kubernetes_helm_certmanager_chart_version
  kubernetes_helm_certmanager_chart_name        = var.kubernetes_helm_certmanager_chart_name
}


resource "time_sleep" "wait_180_seconds" {
  depends_on        = [module.k8s-services-helm.external_dns]
  destroy_duration  = "180s"
}