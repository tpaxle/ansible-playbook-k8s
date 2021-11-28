//output "lb" {
//  value = lookup(
//    data.kubernetes_service.nginx_controller.load_balancer_ingress[0],
//    "hostname",
//    "aaaa",
//  )
//}

locals {
  options = <<MANAGEMENT
----------------------------------------------------
---6.2 External access -----------------------------
----------------------------------------------------
Rules:
    ${var.api_gw_domain_name}.${var.root_public_domain} --> ${data.aws_lb_target_group.https.arn}
    demo-app.${var.default_tags["Infra-Unit"]}.${var.root_public_domain} --> ${data.aws_lb_target_group.http.arn}
    istio.${var.default_tags["Infra-Unit"]}.${var.root_public_domain} --> ${data.aws_lb_target_group.http.arn}

CNAME:
    ${var.api_gw_domain_name}.${var.root_public_domain} --> ${data.aws_lb.selected.dns_name}
    demo-app-${var.default_tags["Infra-Unit"]}.${var.root_public_domain} -->${data.aws_lb.selected.dns_name}
    istio-${var.default_tags["Infra-Unit"]}.${var.root_public_domain} -->${data.aws_lb.selected.dns_name}
    vault-${var.default_tags["Infra-Unit"]}.${var.root_public_domain} -->${data.aws_lb.selected.dns_name}

MANAGEMENT

}

output "toString" {
  value = local.options
}
