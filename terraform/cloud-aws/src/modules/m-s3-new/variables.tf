###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

###############################################################################
##### DEFAULT VARIABLES VPC ###################################################
###############################################################################

variable "object_sequence" {
  description = "Sequence id"
}

################
# Required vars
################

variable "region" {
}

variable "object_id" {
  description = "s3-lb"
}

variable "acl" {
  default = "private"
}

variable "path" {
}

variable "basenamebucket" {}

variable "tags" {
  type = map(string)
  description = "Bucket tags"
}

variable "template_vars" {
  type = map(string)
  description = "template vars"
  default = {}
}