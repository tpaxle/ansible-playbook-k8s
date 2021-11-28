################
# Required vars
################

variable "gw_id" {
  description = "The app peering gw ID"
}

variable "destination_route" {
  description = "CIDR block for the world"
}

variable "route_tables" {
  description = "List of route Tables where the new routes are inserted."
  type        = list(string)
}


