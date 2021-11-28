locals {
  options = <<MANAGEMENT
----------------------------------------------------
---4.1 K8S SECURITY---------------------------------
----------------------------------------------------
Helm Deployment:
  vault:            ${var.kubernetes_helm_vault_chart_name}:${var.kubernetes_helm_vault_chart_version}
Url:
  vault:            vault.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}
  root_token        ${kubernetes_secret.vault-token[0].data.secret-token}
MANAGEMENT
}

locals {
  skip_module_string = <<MANAGEMENT
----------------------------------------------------
---K8S SECURITY SKIPPED ----------------------------
----------------------------------------------------

MANAGEMENT

}
#output "vault_cname" {
#  value = var.enable_k8s_security ? data.kubernetes_service.vault_ingress[0].load_balancer_ingress[0].hostname : ""
#}
output "toString" {
  value = var.enable_k8s_security ? local.options : local.skip_module_string
}
output "vault_token"{
  value = kubernetes_secret.vault-token[0].data.secret-token
}