locals {
  options = <<KUBECONFIG
----------------------------------------------------
---4.1.5 ELK ---------------------------------------
----------------------------------------------------
${module.k8s-elk.toString}
KUBECONFIG

}

output "toString" {
  value = local.options
}


