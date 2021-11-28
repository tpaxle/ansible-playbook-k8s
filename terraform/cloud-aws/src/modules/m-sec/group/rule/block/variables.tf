################
# Required vars
################
variable "description" {
  description = "Security Group rule"
}

variable "rule_type" {
  description = "Type of the rule"
  default     = "ingress"
}

variable "security_group_id" {
  description = "Security Group id"
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

