locals {
  options = <<MANAGEMENT
----------------------------------------------------
---VPN----------------------------------------------
----------------------------------------------------
Instance Created: (${aws_instance.web.id})
  internal ip:      tolist(aws_network_interface.foo.private_ips)[0]
  internal dns:     ${aws_network_interface.foo.private_dns_name}
  external dns:     ${aws_eip.one.public_dns}
  external domain:  ${var.az_dns_vpn}.${var.default_tags["Infra-Unit"]}.${var.root_public_domain}

MANAGEMENT

}

output "toString" {
  value = local.options
}

output "openvpn"{
  value  = data.template_file.openvpn.rendered
}
