locals {
  options = <<KUBECONFIG
----------------------------------------------------
---K8S SERVICES HELM3---------------------
----------------------------------------------------
${module.k8s-services-helm.toString}

${module.k8s-elk.toString}

${module.k8s-observability.toString}

${module.k8s-security.toString}
KUBECONFIG

}

output "toString" {
  value = local.options
}


