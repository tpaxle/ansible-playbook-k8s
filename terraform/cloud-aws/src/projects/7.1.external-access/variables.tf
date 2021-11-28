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

variable "bucket" {
  description = "The name of the tfstate bucket"
}

variable "root_public_domain" {
  description = "Infrastructure root domain"
}

variable "az_dns_vault" {
  default     = "vault"
  description = "Azure DNS CNAME record name"
}

variable "az_dns_name" {
  description = "Dns domain zone in azure"
}

variable "api_gw_domain_name" {
  description = "DNS hostname for the api <api_dns>.<rood_domain>"
}

variable "api_sv_domain_name" {
  description = "DNS hostname for the api <api_dns>.<rood_domain>"
  default = "sv-default"
}



variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = false
}

variable "enable_k8s_security" {
  description = "Enable security module installation"
  default = false
}
variable "vault_enable_public"{
  description = "Enable public load balancer"
  default = false
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}