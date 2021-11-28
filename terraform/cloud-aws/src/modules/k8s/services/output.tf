locals {
  options = <<MANAGEMENT
----------------------------------------------------
---K8S SERVICES---------------------------------
----------------------------------------------------
Helm Deployment:
  external_dns:     stable/external-dns:2.20.4
  dashboard:        ${var.kubernetes_helm_dashboard_chart_name}:${var.kubernetes_helm_dashboard_chart_version}
  ingress:          ${var.kubernetes_helm_ingress_chart_name}:${var.kubernetes_helm_ingress_chart_version}
  state-metrics:    ${var.kubernetes_helm_kube-sm_chart_name}:${var.kubernetes_helm_kube-sm_chart_version}
  metric-metrics:   ${var.kubernetes_helm_metrics-server_chart_name}:${var.kubernetes_helm_metrics-server_chart_version}
URLS:
- http://internal-api.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}
- https://alertmanager.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}:9093
MANAGEMENT

}

output "toString" {
  value = local.options
}

output "external_dns" {
  # Again, the value is not important because we're just
  # using this for its dependencies.
  value = {}

  # Anything that refers to this output must wait until
  # the actions for helm_release.external_dns
  # to have completed first.
  depends_on = [helm_release.external_dns]
}

##########################
####   Cert Manager   ####
##########################
output "certmanager" {
  value = helm_release.cert-manager
}
#########