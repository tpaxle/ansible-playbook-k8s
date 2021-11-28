locals {
  logs_object_sequence = "007"
}
data "aws_caller_identity" "current" {
}

data "aws_s3_bucket" "s3_clourail" {
  bucket = "${module.naming_convention.basenamebucket}${module.naming_convention.default_object_sequence_number}"
}

data "aws_s3_bucket" "s3_logs" {
  bucket = "${module.naming_convention.basenamebucket}${local.logs_object_sequence}"
}

