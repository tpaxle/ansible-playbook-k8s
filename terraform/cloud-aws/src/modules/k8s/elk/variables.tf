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

variable "elk_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

variable "root_infra_domain" {
  description = "Infrastructure root domain"
}

variable "root_public_domain" {
  description = "Infrastructure public domain"
}

variable "enable_k8s_elk" {
  description = "Enable elk module installation"
  default = false
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = false
}