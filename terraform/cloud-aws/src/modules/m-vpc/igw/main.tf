###################
# Internet Gateway
###################
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = "${var.basenameigw}${var.object_sequence}"
    },
    var.default_tags,
  )
}

