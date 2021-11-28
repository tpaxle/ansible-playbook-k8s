###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "security_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

variable "login_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

variable "kubernetes_helm_vault_chart_version" {
  description = "Helm Consul chart version"
  default     = "0.18.0"
}

variable "kubernetes_helm_vault_chart_name" {
  description = "Helm  Thanos chart version"
  default     = "vault"
}

variable "root_infra_domain" {
  description = "Infrastructure domain"
}

######
## Cert Manager
######
variable "kubernetes_helm_certmanager_chart_version" {
  description = "Helm Cert Manager chart version"
  default     = "1.0.1"
}
variable "kubernetes_helm_certmanager_chart_name" {
  description = "Helm  Cert Manager chart version"
  default     = "cert-manager"
}
######

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


variable "region" {
  description = "Region where instances kms will be used"
}

variable "enable_k8s_security" {
  description = "Enable security module installation"
  default     = false
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = false
}
variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}
variable "vault_ip_access"{
  description = "Ip whitelist"
  type    = list(string)
  default = []
}
variable "vault_enable_public"{
  description = "Enable public load balancer"
  default = "0"
}
