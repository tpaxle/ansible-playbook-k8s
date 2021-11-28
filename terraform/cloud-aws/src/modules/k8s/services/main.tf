###############################################################################
##### K8S SERVICES HELM #######################################################
###############################################################################
#### 1. external_dns
#### 2. K8S dashboard
#### 3. Nginx Ingress controller (To delete with istio integration)
#### 4. K8S state-metrics
#### 5. K8S metric server

resource "helm_release" "external_dns" {
  name      = "external-dns"
  chart     = var.kubernetes_helm_externaldns_chart_name
  version   = var.kubernetes_helm_externaldns_chart_version
  repository = "https://charts.bitnami.com/bitnami"
  namespace = "kube-system"

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
  set {
    name  = "domainFilters[0]"
    value = "${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}"
  }

}
resource "helm_release" "dashboard" {
  name      = "${var.default_tags["_Application"]}-eks-dashboard-${var.default_tags["_Environment"]}"
  chart     = var.kubernetes_helm_dashboard_chart_name
  version   = var.kubernetes_helm_dashboard_chart_version
  repository = "https://kubernetes.github.io/dashboard/"
  namespace = "kube-system"

  set {
    name  = "rbac.create"
    value = "true"
  }
}
#resource "helm_release" "state-metrics" {
#  name      = "kube-state-metrics"
#  chart     = var.kubernetes_helm_kube-sm_chart_name
#  version   = var.kubernetes_helm_kube-sm_chart_version
#  repository = "https://prometheus-community.github.io/helm-charts"
#  namespace = "kube-system"
#  set {
#    name  = "rbac.create"
#    value = "true"
#  }
#}

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