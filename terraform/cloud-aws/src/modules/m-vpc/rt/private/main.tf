################
# Private routes
################

resource "aws_route" "route" {
  count                  = length(var.aws_azs)
  route_table_id         = var.route_tables[count.index]
  nat_gateway_id         = var.gw_id[count.index]
  destination_cidr_block = var.external_global_cidr
}

