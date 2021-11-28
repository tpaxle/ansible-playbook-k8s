###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "region" {
  description = "The AWS region"
}

variable "root_infra_domain" {
  description = "Infrastructure root domain"
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}

variable "kubernetes_helm_vault_chart_version" {
  description = "Helm Consul chart version"
  default     = "0.18.0"
}

variable "kubernetes_helm_vault_chart_name" {
  description = "Helm  Thanos chart version"
  default     = "vault"
}

variable "enable_k8s_security" {
  description = "Enable security module installation"
  default     = false
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = false
}

######
## Keycloak
######
variable "kubernetes_helm_keycloak_chart_version" {
  description = "Helm Keycloak chart version"
  default     = "9.1.0"
}

variable "kubernetes_helm_keycloak_chart_name" {
  description = "Helm  Keycloak chart version"
  default     = "keycloak"
}

variable "enable_k8s_keycloak" {
  description = "Enable keycloak installation"
  default     = false
}
########
########

variable "vault_ip_access"{
  description = "Ip whitelist"
  type    = list(string)
  default = []
}

variable "vault_enable_public"{
  description = "Enable public load balancer"
  default = "0"
}