locals {
  options = <<MANAGEMENT
----------------------------------------------------
---3.4 Management-----------------------------------
----------------------------------------------------
${module.m-vpn.toString}
MANAGEMENT

}

output "toString" {
  value = local.options
}

