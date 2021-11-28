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
##### DEFAULT VPC CONFIGURATION ###############################################
###############################################################################
variable "aws_azs" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "subnet_sufix" {
  description = "Sufix subnet"
}

variable "list_subnets" {
  type = list(string)
}

variable "public_subnets_tags" {
  type = map(string)
}
variable "zones"{
  type = map(string)
  default = {
    0 = "a"
    1 = "b"
    2 = "c"
  }
}
variable "vpc_id" {
  description = "The VPC ID"
}

variable "map_public_ip_on_launch" {
  default = true
}

variable "basenamesnt" {}