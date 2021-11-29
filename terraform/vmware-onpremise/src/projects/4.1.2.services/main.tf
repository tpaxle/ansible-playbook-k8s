###############################################################################
##### K8S SERVICES HELM #######################################################
###############################################################################
#### 1. external_dns
#### 2. K8S dashboard
#### 3. Nginx Ingress controller (To delete with istio integration)
#### 4. K8S state-metrics
#### 5. K8S metric server

resource "helm_release" "metric-metrics" {
  name      = "metrics-server"
  chart     = var.kubernetes_helm_metrics-server_chart_name
  version   = var.kubernetes_helm_metrics-server_chart_version
  repository = "https://charts.bitnami.com/bitnami"
  namespace = "kube-system"
}

######################################################################################################################################################
######################CERT MANAGER##################################################################################################
######################################################################################################################################################

resource "helm_release" "cert-manager" {
  name              = "${var.default_tags["_Application"]}-eks-certmanager-${var.default_tags["_Environment"]}"
  chart             = var.kubernetes_helm_certmanager_chart_name
  version           = var.kubernetes_helm_certmanager_chart_version
  force_update      = "true"
  namespace         = "addons"
  repository        = "https://charts.jetstack.io"
  create_namespace  = true
  set {
    name  = "installCRDs"
    value = "true"
  }
  #values     = [data.template_file.helm_certmanager.rendered]
  #depends_on = [helm_release.stable-consul]
}


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
