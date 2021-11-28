variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "dc_name" {
  description = "DC name"
  default = "dc1"
}

variable "dc_cluster_name" {
  description = "DC name"
  default = "cluster1"
}
variable "dc_template_name" {
  description = "DC name"
  default = "dc1"
}

variable "template_name"{
    description = "template name"
}

variable "datastorage_name" {
  description = "dtastorage name"
  default = "datastore1"
}

variable "master_cpu"{
    description = "cpu"
    default = 2
}

variable "master_ram"{
    description = "ram"
    default = "2048"
}

variable "domian" {
    description = "hola"
}
