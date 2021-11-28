locals {
  options = <<KUBECONFIG
----------------------------------------------------
---4.1.2 SERVICES ----------------------------------
----------------------------------------------------
${module.k8s-services-helm.toString}
KUBECONFIG

}

output "toString" {
  value = local.options
}


