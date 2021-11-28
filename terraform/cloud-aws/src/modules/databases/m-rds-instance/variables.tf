###############################################################################
##### DEFAULT VARIABLES  ######################################################
###############################################################################

variable "object_sequence" {
  description = "Sequence id"
}

variable "publicaccesible" {
  default = false
}
########################
## Variables
########################

variable "engine" {
  default     = "aurora-postgresql"
  description = "The name of the database engine to be used for this DB cluster."
}

variable "engine_version" {
  default     = "9.6.12"
  description = "The database engine version"
}

variable "database_name" {
  description = "Identifier for the cluster which will be used in database_name, alphanumeric only"
}

variable "instance_type"{
    description = "Instnce type"
    default = "db.r5.large"
}

variable "cluster_id"{
  description = "Cluster id"
}

variable "baserdsname" {}