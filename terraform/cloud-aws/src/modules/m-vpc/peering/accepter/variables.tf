###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "vpc_peering_id" {
  description = "Shared account ID"
}

variable "provider_name" {
  description = "Shared vpc ID"
}

variable "shared_role_arn" {
  description = "Shared vpc ID"
}

variable "region" {
  description = "Shared vpc ID"
}
