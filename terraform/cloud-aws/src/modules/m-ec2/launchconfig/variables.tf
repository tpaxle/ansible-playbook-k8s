################
# Required vars
################
variable "associate_public_ip_address" {
  description = "associate public ip addres"
  default     = false
}

variable "iam_instance_profile" {
  description = "IAM Profile"
}

variable "image_id" {
  description = "EC2 image id"
}

variable "instance_type" {
  description = "EC2 instance type id"
}

variable "security_groups" {
  description = "Security Groups id"
  type        = list(string)
}

variable "key_name" {
  description = "Key name"
}

variable "name_prefix" {
  description = "Key name"
}

variable "user_data_base64" {
  description = "Key name"
}

