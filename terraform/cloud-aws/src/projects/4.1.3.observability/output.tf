locals {
  options = <<KUBECONFIG
----------------------------------------------------
---4.1.3 OBSERVABILITY -----------------------------
----------------------------------------------------
${module.k8s-observability.toString}
KUBECONFIG

}

output "toString" {
  value = local.options
}


