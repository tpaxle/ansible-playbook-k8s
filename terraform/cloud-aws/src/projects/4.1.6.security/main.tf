module "k8s-security" {
  source                                    = "../../modules/k8s/security"
  default_tags                              = var.default_tags
  root_infra_domain                         = var.root_infra_domain
  kubernetes_helm_vault_chart_version   = var.kubernetes_helm_vault_chart_version
  kubernetes_helm_vault_chart_name      = var.kubernetes_helm_vault_chart_name
  kubernetes_helm_keycloak_chart_version= var.kubernetes_helm_keycloak_chart_version
  kubernetes_helm_keycloak_chart_name   = var.kubernetes_helm_keycloak_chart_name  
  region                                = var.region
  enable_k8s_security                   = var.enable_k8s_security
  enable_k8s_istio                      = var.enable_k8s_istio
  naming_convention_definition          = var.naming_convention_definition
  vault_ip_access                       = var.vault_ip_access
  vault_enable_public                   = var.vault_enable_public
  enable_k8s_keycloak                       = var.enable_k8s_keycloak
}
