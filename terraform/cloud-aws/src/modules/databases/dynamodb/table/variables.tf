variable "name" {
  description = "Dynamo DB Table Name"
}
variable "hash_key" {
  default = "Path"
  description = "Hash key"
}

variable "range_key" {
  default = "Key"
  description = "Hash key"
}

variable "read_capacity" {
  default = "2"
  description = "Hash key"
}

variable "write_capacity" {
  default = "2"
  description = "Hash key"
}


variable "attribute" {
  description = "Naming Convention Definition"
  type        = list(map(string))
  default = [
        {
            name = "Path"
            type = "S"
        },
        {
            name = "Key"
            type = "S"
        }
    ]
}

###############################################################################
##### DEFAULT VARIABLES  ######################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}