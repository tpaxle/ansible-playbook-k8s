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

variable "root_infra_domain" {
  description = "Infrastructure root domain"
}

variable "eks_monitoring_worker_instance_type" {
  default     = "t2.2xlarge"
  description = "EKS Monitoring Worker instance type"
}

variable "eks_worker_instance_type" {
  default     = "t2.2xlarge"
  description = "EKS Worker instance type"
}

variable "eks_worker_desired" {
  default     = "3"
  description = "EKS Worker ASG desired count"
}

variable "eks_worker_min" {
  default     = "1"
  description = "EKS Worker ASG min count"
}

variable "eks_worker_max" {
  default     = "11"
  description = "EKS Worker ASG max count"
}

variable "eks_version" {
  default     = "1.15"
  description = "EKS Version"
}

variable "eks_other_access_list" {
  type    = list
  default = []
}

variable "envs_path" {
  description = "Environment relative folder path"
  default     = "../../../envs"
}

variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}

variable "env_folder_name" {
  description = "folder name in the env_path with environment files"
}