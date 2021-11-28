###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "region" {
  description = "Region to base all of our commands on"
}

variable "vault_user_arn" {
  description = "ARN of Vault user that is used to assume SSO roles in this account"
}
