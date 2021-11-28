locals {
  gw = "${length(var.natgw_connections) > 0 ? ["test"] : []}"
}