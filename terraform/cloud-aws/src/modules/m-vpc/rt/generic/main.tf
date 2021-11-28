################
# Public table route
################
resource "aws_route_table" "rt" {
  count  = length(var.aws_azs)
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = "${var.basenamertb}${var.object_sequence}-${var.zones[count.index]}"
    },
    var.public_rt_tags,
    var.default_tags,
  )

  dynamic "route" {
    for_each = var.igw_connections

    content {
      cidr_block      = "0.0.0.0/0"
      gateway_id      = route.value
    }
  }

  dynamic "route" {
    for_each = local.gw
    content {
      cidr_block      = "0.0.0.0/0"
      nat_gateway_id      = var.natgw_connections[count.index]
    }

  }

}

##########################
# Route table association
##########################
resource "aws_route_table_association" "rta" {
  count          = length(var.aws_azs)
  subnet_id      = var.subnets_id[count.index]
  route_table_id = aws_route_table.rt[count.index].id
}

