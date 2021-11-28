###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "shared_account" {
  description = "Shared account ID"
}

variable "shared_vpc" {
  description = "Shared vpc ID"
}

variable "vpc_id" {
  description = "Locl vpc ID"
}

