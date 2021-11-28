################
# Public routes
################

resource "aws_route" "route" {
  count                  = length(var.aws_azs)
  route_table_id         = var.route_tables[count.index]
  gateway_id             = var.gw_id
  destination_cidr_block = var.external_global_cidr
}

