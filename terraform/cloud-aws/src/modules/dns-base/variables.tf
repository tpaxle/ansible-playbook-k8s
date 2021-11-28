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

variable "domain_prefix" {
  description = "For examole the environment name e.g. dev, prod"
}

variable "root_domain_name" {
  description = "The value of the default domain name"
}

locals {
  domain_name = "${var.domain_prefix}.${var.root_domain_name}"
}

variable "tag_zone_type" {
  description = "Tag zone type"
}

variable "tag_infra_unit" {
  description = "tag infra unit"
}

variable "vpc_id" {
  description = "VPC ID to assign DNS Zone"
}

variable "basenamedns" {}
