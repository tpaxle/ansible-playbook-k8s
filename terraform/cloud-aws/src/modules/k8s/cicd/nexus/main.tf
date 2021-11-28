
resource "helm_release" "stable-nexus" {
  count = local.enable_service

  name              = "${var.default_tags["_Application"]}-eks-nexus-${var.default_tags["_Environment"]}"
  chart             = var.kubernetes_helm_nexus_chart_name
  version           = var.kubernetes_helm_nexus_chart_version
  force_update      = "true"
  repository        = "https://oteemo.github.io/charts"
  create_namespace  = "true"
  namespace         = "cicd"
  values            = [data.template_file.helm_nexus[0].rendered]
}