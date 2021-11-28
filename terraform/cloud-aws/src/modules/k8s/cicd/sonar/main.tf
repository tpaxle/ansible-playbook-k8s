
resource "helm_release" "stable-sonar" {
  count = local.enable_service

  name              = "${var.default_tags["_Application"]}-eks-sonar-${var.default_tags["_Environment"]}"
  chart             = var.kubernetes_helm_sonar_chart_name
  version           = var.kubernetes_helm_sonar_chart_version
  force_update      = "true"
  repository        = "https://oteemo.github.io/charts"
  create_namespace  = "true"
  namespace         = "cicd"
  values            = [data.template_file.helm_sonar[0].rendered]
}