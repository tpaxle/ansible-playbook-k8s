module "k8s-services-helm" {
  source                                        = "../services"
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
  kubernetes_helm_certmanager_chart_version     = var.kubernetes_helm_certmanager_chart_version
  kubernetes_helm_certmanager_chart_name        = var.kubernetes_helm_certmanager_chart_name
  root_infra_domain                             = var.root_infra_domain
  region                                        = var.region
}


resource "time_sleep" "wait_180_seconds" {
  depends_on        = [module.k8s-services-helm.external_dns]
  destroy_duration  = "180s"
}

module "k8s-elk" {
  source              = "../elk"
  region              = var.region
  role_arn            = var.role_arn
  elk_depends_on      = [time_sleep.wait_180_seconds]
  root_infra_domain   = var.root_infra_domain
  root_public_domain  = var.root_public_domain
  enable_k8s_elk      = var.enable_k8s_elk
  enable_k8s_istio    = var.enable_k8s_istio
  default_tags        = var.default_tags
}

module "k8s-observability" {
  source                                      = "../observability"
  default_tags                                = var.default_tags
  region                                      = var.region
  access_key                                  = var.access_key
  secret_key                                  = var.secret_key
  observability_depends_on                    = [time_sleep.wait_180_seconds]
  kubernetes_helm_prometheusop_chart_version  = var.kubernetes_helm_prometheusop_chart_version
  kubernetes_helm_prometheusop_chart_name     = var.kubernetes_helm_prometheusop_chart_name
  root_infra_domain                           = var.root_infra_domain
  root_public_domain                          = var.root_public_domain
  enable_k8s_istio                            = var.enable_k8s_istio
  enable_k8s_observability                    = var.enable_k8s_observability
}

module "k8s-security" {
  source                                        = "../security"
  default_tags                                  = var.default_tags
  security_depends_on                           = [module.k8s-observability.stable-prometheus-operator]
  login_depends_on                              = [time_sleep.wait_180_seconds]
  root_infra_domain                             = var.root_infra_domain
  kubernetes_helm_vault_chart_version           = var.kubernetes_helm_vault_chart_version
  kubernetes_helm_vault_chart_name              = var.kubernetes_helm_vault_chart_name
  kubernetes_helm_keycloak_chart_name           = var.kubernetes_helm_keycloak_chart_name
  kubernetes_helm_keycloak_chart_version        = var.kubernetes_helm_keycloak_chart_version
  region                                        = var.region
  enable_k8s_istio                              = var.enable_k8s_istio
  enable_k8s_security                           = var.enable_k8s_security
  role_arn                                      = var.role_arn
  enable_k8s_keycloak                               = var.enable_k8s_keycloak
}