################
# Required vars
################

variable "gw_id" {
  description = "The app nat gw ID"
  type        = list(string)
}

variable "external_global_cidr" {
  description = "CIDR block for the world"
  default     = "0.0.0.0/0"
}

variable "aws_azs" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "route_tables" {
  description = "List of route Tables"
  type        = list(string)
}

