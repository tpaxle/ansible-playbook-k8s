###############################################################################
##### K8S Observability #######################################################
###############################################################################
#### 1. Thanos
#### 2. PrometheusOperator

resource "helm_release" "stable-thanos" {
  count = local.count_k8s_observability

  name         = "${var.default_tags["_Application"]}-eks-thanos-${var.default_tags["_Environment"]}"
  chart        = "thanos"
  #version      = "8.13.8"
  force_update = "true"
  repository   = "https://kubernetes-charts.banzaicloud.com"
  create_namespace  = "true"
  namespace    = "monitoring"
  values     = [data.template_file.helm_thanos[0].rendered]

  depends_on = [var.observability_depends_on]
}


resource "helm_release" "stable-prometheus-operator" {
  count = local.count_k8s_observability

  name         = "${var.default_tags["_Application"]}-eks-prometheusops-${var.default_tags["_Environment"]}"
  chart        = var.kubernetes_helm_prometheusop_chart_name
  version      = var.kubernetes_helm_prometheusop_chart_version
  repository = "https://prometheus-community.github.io/helm-charts"

  force_update = "true"
  create_namespace  = "true"
  namespace    = "monitoring"

  # create_namespace  = true
  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "txtPrefix"
    value = "dns"
  }
  values     = [data.template_file.helm_prometheus[0].rendered]

  depends_on = [helm_release.stable-thanos]
}
