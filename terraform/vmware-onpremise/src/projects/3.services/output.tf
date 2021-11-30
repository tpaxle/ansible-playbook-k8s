locals {
  options = <<KUBECONFIG
----------------------------------------------------
---4.1.2 SERVICES ----------------------------------
----------------------------------------------------
KUBECONFIG

}

output "toString" {
  value = local.options
}


