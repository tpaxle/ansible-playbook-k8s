##############
# S3 Endpoint
##############
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = var.service_name

  policy = var.policy

  route_table_ids = var.route_tables
}

