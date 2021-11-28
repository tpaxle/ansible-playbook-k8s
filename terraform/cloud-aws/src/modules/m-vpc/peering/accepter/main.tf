resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = var.vpc_peering_id
  auto_accept               = true

  provider                    = aws.shared
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(
    {
      "Name" = "${var.default_tags["_Application"]}-vpc-peer-${var.default_tags["_Environment"]}-shared"
      "Side" = "Accepter"
    },
    var.default_tags,
  )
}
