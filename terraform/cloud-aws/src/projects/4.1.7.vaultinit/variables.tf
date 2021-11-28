###############################################################################
##### DEFAULT VARIABLES + #####################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "role_arn" {
  description = "The assumed role ARN"
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


###############################################################################
##### GITHUB ###################################################
###############################################################################

variable "github_organization" {
}
variable "github_adminteam" {
}
variable "az_dns_vault" {
  default     = "vault"
  description = "Azure DNS CNAME record name"
}