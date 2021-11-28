data "aws_vpc" "primary" {
  tags = {
    Name = "${module.naming_convention.basenamevpc}${module.naming_convention.default_object_sequence_number}"
  }
}

