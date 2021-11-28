locals {
  options = <<KUBECONFIG
----------------------------------------------------
---4.1.4 SECURITY ----------------------------------
----------------------------------------------------
${module.k8s-security.toString}
KUBECONFIG

}

output "toString" {
  sensitive = true
  value = local.options
}


