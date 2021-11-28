###############################################################################
##### DEFAULT VARIABLES VPC ###################################################
###############################################################################

variable "object_sequence" {
  type        = string
  description = "Sequence id"
}

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

###############################################################################
##### DEFAULT ROUTE CONFIGURATION #############################################
###############################################################################

variable "vpc_id" {
  description = "The VPC ID"
}

variable "public_rt_tags" {
  type = map(string)
}

variable "aws_azs" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "subnets_id" {
  description = "List of Subnets ids"
  type        = list(string)
}

variable "zones"{
  type = map(string)
  default = {
    0 = "a"
    1 = "b"
    2 = "c"
  }
}

variable "basenamertb" {}


variable "igw_connections"{
  description = "IGW id"
  default     = []
}
variable "natgw_connections"{
  description = "NAT GW id"
  default     = []
}