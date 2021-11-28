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
##### DEFAULT VPC CONFIGURATION ###############################################
###############################################################################
variable "enable_dns_support" {
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
}

variable "enable_dns_hostnames" {
  default     = true
  description = "A boolean flag to enable/disable DNS hostnames in the VPC Defaults false."
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
}

variable "basenamevpc" {
}

