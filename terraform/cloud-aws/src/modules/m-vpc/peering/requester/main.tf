resource "aws_vpc_peering_connection" "connection" {
  peer_owner_id = var.shared_account
  peer_vpc_id   = var.shared_vpc
  vpc_id        = var.vpc_id

  #auto_accept   = true

  #requester {
  #  allow_remote_vpc_dns_resolution = true
  #}
  #accepter {
  # allow_remote_vpc_dns_resolution = true
  #}

  tags = merge(
    {
      "Name" = "${var.default_tags["_Application"]}-vpc-peer-${var.default_tags["_Environment"]}-shared"
      "Side" = "Requester"
    },
    var.default_tags,
  )
}

