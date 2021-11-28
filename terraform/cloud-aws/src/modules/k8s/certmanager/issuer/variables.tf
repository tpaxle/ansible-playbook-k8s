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
  default     = "0.7.0"
}

variable "kubernetes_helm_vault_chart_name" {
  description = "Helm  Thanos chart version"
  default     = "vault"
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}

variable "pki_vault_path" {
  description = "PKI PATH"
}
variable "enable_k8s_security" {
  description = "Enable security module installation"
  default     = true
}
