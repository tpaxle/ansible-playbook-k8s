locals {
  options = <<MANAGEMENT
----------------------------------------------------
---K8S OBSERVABILITY---------------------------------
----------------------------------------------------
Helm Deployment:
  thanos:           banzaicloud/thanos:8.13.8
  prometheus-ope:   ${var.kubernetes_helm_prometheusop_chart_name}:${var.kubernetes_helm_prometheusop_chart_version}
URLS:
- http://prometheus.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}:9090
- https://thanos.${var.default_tags["Infra-Unit"]}.${var.root_public_domain}:10902
- http://grafana.${var.default_tags["Infra-Unit"]}.${var.root_public_domain}
MANAGEMENT

}

locals {
  skip_module_string = <<MANAGEMENT
----------------------------------------------------
---K8S OBSERVABILITY SKIPPED ---------------------------------
----------------------------------------------------

MANAGEMENT

}

output "toString" {
  value = var.enable_k8s_observability ? local.options : local.skip_module_string
}

output "stable-prometheus-operator" {
  # Again, the value is not important because we're just
  # using this for its dependencies.
  value = {}

  # Anything that refers to this output must wait until
  # the actions for helm_release.stable-prometheus-operator
  # to have completed first.
  depends_on = [helm_release.stable-prometheus-operator]
}