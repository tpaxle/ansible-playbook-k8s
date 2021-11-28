###############################################################################
##### Santander Standard Tags #################################################
###############################################################################

variable "region" {
  description = "The AWS region"
}



variable "root_account" {
}

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "elb_log_accounts" {
  type = map(string)

  description = "Amazon provided aws account IDs to be used for elb logs."
  default = {
    eu-west-2 = "652711504416"
    eu-west-1 = "156460612806"
  }
}

variable "envs_path" {
  description = "Environment relative folder path"
  default     = "../../../envs"
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}

