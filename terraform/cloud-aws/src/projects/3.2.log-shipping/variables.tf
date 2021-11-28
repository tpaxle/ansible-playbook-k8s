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

variable "cloudwatch_log_groups" {
  type = list
}

variable "root_role_arn" {
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}

variable "enable_cloudtrail" {
  description = "Create cloudtrail event flag"
  default = false
}
