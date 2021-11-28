###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "region" {
  description = "Region where instances get created"
}

#############################################################
#############################################################
variable "ecr_repository"{
  description = "Default Tags"
  type        = list(string)
}