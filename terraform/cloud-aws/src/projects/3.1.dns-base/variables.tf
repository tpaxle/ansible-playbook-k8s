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

variable "root_role_arn" {
}

variable "root_infra_domain" {
  description = "Infrastructure domain"
}

variable "root_public_domain" {
  description = "Public domain"
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}