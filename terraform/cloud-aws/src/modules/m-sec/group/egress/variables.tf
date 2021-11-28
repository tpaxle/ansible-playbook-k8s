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
##### IGW OPTIONS #############################################################
###############################################################################

variable "vpc_id" {
  description = "The VPC ID"
}

variable "es_access_cidr" {
  type        = list(string)
  description = "CIDR"
}

variable "from_port" {
  description = "From Port"
}

variable "to_port" {
  description = "To Port"
}

variable "protocol" {
  description = "To Port"
  default     = "tcp"
}

variable "basenamesgr" {}

