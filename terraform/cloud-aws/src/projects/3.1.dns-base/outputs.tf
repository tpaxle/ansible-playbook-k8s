locals {
  options = <<TOSTRINGA
----------------------------------------------------
---3.1 INTERNAL DNS CONFIG -------------------------
----------------------------------------------------
DNS Created:  (${module.dns_base_env_infra.subdomain_zone_id})
    Domain:   ${module.dns_base_env_infra.subdomain_name}
TOSTRINGA

}

output "toString" {
  value = local.options
}

