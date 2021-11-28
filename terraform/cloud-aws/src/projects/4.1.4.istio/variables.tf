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

variable "root_public_domain" {
  description = "Infrastructure public domain"
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = false
}
variable "istio_version" {
  default = "1.12.0"
}