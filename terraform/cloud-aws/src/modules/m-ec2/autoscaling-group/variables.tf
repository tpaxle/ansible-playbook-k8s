################
# Required vars
################
variable "desired_capacity" {
  description = "Desire capacity"
  default     = "1"
}

variable "max_size" {
  description = "Desire capacity"
  default     = "2"
}

variable "min_size" {
  description = "Desire capacity"
  default     = "0"
}

variable "name" {
  description = "Desire capacity"
  default     = "0"
}

variable "subnet_ids" {
  description = "Desire capacity"
  type        = list(string)
}

variable "cluster_id" {
  description = "Desire capacity"
}

variable "launch_config_id" {
  description = "Desire capacity"
}

