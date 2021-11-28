###############################################################################
##### NAMING CONVENTION CONFIGURATION IMPORT ##################################
###############################################################################

resource "aws_dynamodb_table" "dynamodb-table" {
  name           = var.name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  
    hash_key       = var.hash_key
    range_key      = var.range_key
    
    dynamic "attribute" {
      for_each = [for s in var.attribute: {
        name   = s.name
        type   = s.type
      }]
      content {
        name           = attribute.value.name
        type           = attribute.value.type
      }
    }      

  tags = var.default_tags
}