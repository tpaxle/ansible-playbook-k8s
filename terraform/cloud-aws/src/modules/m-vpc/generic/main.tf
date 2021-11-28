###############################################################################
##### VPC GENERATION ##########################################################
###############################################################################

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      "Name" = "${var.basenamevpc}${var.object_sequence}"
    },
    var.default_tags,
  )

  lifecycle {
    ignore_changes = [tags]
  }
}

