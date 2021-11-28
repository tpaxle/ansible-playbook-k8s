################
# Required vars
################

variable "service_name" {
  description = "Service name"
}

variable "policy" {
  description = "Policy file"
}

variable "route_tables" {
  type = list(string)
}

variable "vpc_id" {
  description = "Policy file"
}

