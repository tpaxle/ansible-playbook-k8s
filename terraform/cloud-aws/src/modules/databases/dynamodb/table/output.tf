locals {
  options = <<MANAGEMENT
----------------------------------------------------
---DYNAMODB TABLE ----------------------------------
----------------------------------------------------
Instance Created: (${aws_dynamodb_table.dynamodb-table.id})

MANAGEMENT

}

output "toString" {
  value = local.options
}

output "name" {
  value = aws_dynamodb_table.dynamodb-table.name
}