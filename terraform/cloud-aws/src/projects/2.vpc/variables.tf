###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}


variable "region" {
  description = "The AWS region"
}


###############################################################################
##### SUBNET VARIABLES ########################################################
###############################################################################


variable "aws_azs" {
  description = "List of availability zones to use"
  type        = list(string)
}


variable "vpc_cidr_block" {
  description = "VPC CIDR block"
}

variable "public_subnets" {
  type = list(string)
}

variable "public_subnets_tags" {
  type = map(string)
}

variable "public_rt_tags" {
  type = map(string)
}

variable "private_subnets_eks" {
  type = list(string)
}

variable "private_subnets_tags_eks" {
  type = map(string)
}

variable "private_rt_tags_eks" {
  type = map(string)
}

variable "external_global_cidr" {
  description = "CIDR block for the world"
  default     = "0.0.0.0/0"
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}

variable "root_public_domain" {
  description = "Infrastructure public domain"
}