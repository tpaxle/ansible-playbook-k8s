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

variable "istio_version" {
  description = "Istio version"
  default = "1.6.8"
}

variable "root_infra_domain" {
  description = "Infrastructure domain"
}

variable "root_public_domain" {
  description = "Infrastructure public domain"
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = true
}