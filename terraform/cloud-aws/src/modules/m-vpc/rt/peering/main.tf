################
# Private routes
################

resource "aws_route" "route" {
  count                  = length(var.route_tables)
  route_table_id         = var.route_tables[count.index]
  vpc_peering_connection_id  = var.gw_id
  destination_cidr_block = var.destination_route
}

