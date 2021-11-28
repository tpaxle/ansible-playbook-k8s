variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "dc_name" {
  description = "DC name"
  default = "dc1"
}

variable "datastorage_name" {
  description = "dtastorage name"
  default = "datastore1"
}