###############################################################################
##### DEFAULT VARIABLES VPC ###################################################
###############################################################################

variable "object_sequence" {
  description = "Sequence id"
}

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

###############################################################################
##### LB OPTIONS ##############################################################
###############################################################################

variable "subnets" {
  type = list(string)
}

variable "vpcid" {
  description = "ID VPc"
}

variable "bucketname" {
}

variable "certpolicy" {
  default = "ELBSecurityPolicy-2016-08"
}

variable "certificatearn" {
}

variable "securitygroups" {
  type = list(string)
}

variable "basenamenlb" {}