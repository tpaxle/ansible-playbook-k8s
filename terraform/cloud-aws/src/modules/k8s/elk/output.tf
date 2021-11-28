locals {
  options = <<MANAGEMENT
----------------------------------------------------
---K8S ELK---------------------------------
----------------------------------------------------
Helm Deployment:
  ELK:            7.6.1
URLS:

- https://kibana.${var.default_tags["Infra-Unit"]}.${var.root_public_domain}
- https://elk.${var.default_tags["Infra-Unit"]}.${var.root_public_domain}:9200
MANAGEMENT

}

locals {
  skip_module_string = <<MANAGEMENT
----------------------------------------------------
---K8S ELK SKIPPED ---------------------------------
----------------------------------------------------

MANAGEMENT

}

output "toString" {
  value = var.enable_k8s_elk ? local.options : local.skip_module_string
}
