###############################################################################
##### DEFAULT VARIABLES  ######################################################
###############################################################################

variable "object_sequence" {
  description = "Sequence id"
}

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

###############################################################################
##### NGW OPTIONS #############################################################
###############################################################################
variable "aws_azs" {
  type = list(string)
}

variable "subnets_id" {
  type = list(string)
}


variable "zones"{
  type = map(string)
  default = {
    0 = "a"
    1 = "b"
    2 = "c"
  }
}

variable "basenameeip" {}
variable "basenamengw" {}