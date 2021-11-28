variable "zone_id" {
  description = "Route53 zone ID"
}

variable "new_name" {
  description = "Route53 zone ID"
}

variable "records" {
  description = "Record name to point cname"
}

variable "extra" {
 default = "test"
}