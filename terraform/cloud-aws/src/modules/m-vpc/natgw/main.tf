##############
# NAT Gateway
##############
resource "aws_eip" "eip" {
  count = length(var.aws_azs)
  vpc   = true

  tags = merge(
    {
      "Name" = "${var.basenameeip}${var.object_sequence}-${var.zones[count.index]}"
    },
    var.default_tags,
  )
}

resource "aws_nat_gateway" "ngw" {
  count         = length(var.aws_azs)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = var.subnets_id[count.index]

  tags = merge(
    {
      "Name" = "${var.basenamengw}${var.object_sequence}-${var.zones[count.index]}"
    },
    var.default_tags,
  )
}
