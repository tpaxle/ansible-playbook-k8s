variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "dc_name" {
  description = "DC name"
  default = "dc1"
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