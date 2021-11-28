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

########################
## Variables
########################

variable "engine" {
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster."
}

variable "master_password" {
  description = "Password for the master database user"
  default     = "changeme"
}

variable "master_username" {
  description = "Username for the master database user"
  default     = "master"
}

variable "aws_azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "subnets_ids" {
  description = "Availability Zones"
  type        = list(string)
}

variable "deletion_protection" {
  description = "Delete protection"
  default     = "false"
}

variable "vpc_security_group_ids" {
  description = "Security Groups"
  type        = list(string)
}

variable "storage_encrypted" {
  description = "Encryption Data"
  default     = true
}

variable "kms_key_id" {
  description = "KMS ID Data"
  default     = true
}

variable "instance_type"{
    description = "Instnce type"
    default = "db.r4.large"
}
variable "rds_preferred_maintenance_window" {
    description = "Maintenance Windows"
    type        = string
    default     = "wed:03:00-wed:04:00"
}


###Defautl values
variable "subnetgroupname" {
    description = "Subnet group name"
    default     = ""

}
variable "dbclustername" {
    description = "Cluster DB name"
    default     = ""

}
variable "database_name" {
    description = "database name"
    default     = ""
}

variable "baserdsname" {}