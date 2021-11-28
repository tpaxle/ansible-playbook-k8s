################
# Public subnet
################
resource "aws_subnet" "sub" {
  count                   = length(var.list_subnets)
  vpc_id                  = var.vpc_id
  cidr_block              = var.list_subnets[count.index]
  availability_zone       = var.aws_azs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      "Name" = "${var.basenamesnt}${var.object_sequence}-${var.zones[count.index]}"
    },
    var.public_subnets_tags,
    var.default_tags,
  )

  lifecycle {
    ignore_changes = [tags]
  }
}
