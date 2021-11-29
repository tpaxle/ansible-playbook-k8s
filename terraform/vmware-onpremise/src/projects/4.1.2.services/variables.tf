###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "root_infra_domain" {
  description = "Infrastructure root domain"
}

variable "enable_k8s_observability" {}

variable "region" {
  description = "The AWS region"
}

variable "bucket" {
  description = "The name of the tfstate bucket"
}

variable "kubernetes_helm_externaldns_chart_name" {
  description = "Helm  External DNS chart name"
  default     = "stable/external-dns"
}

variable "kubernetes_helm_externaldns_chart_version" {
  description = "Helm  External DNS chart version"
  default     = "2.20.4"
}

variable "kubernetes_helm_dashboard_chart_name" {
  description = "Helm Dashboard Chart Name"
  default     = "stable/kubernetes-dashboard"
}

variable "kubernetes_helm_dashboard_chart_version" {
  description = "Helm Dashboard chart version"
  default     = "1.10.1"
}

variable "kubernetes_helm_kube-sm_chart_name" {
  description = "Helm Kube Static Metrics Chart Version"
  default     = "stable/kube-state-metrics"
}

variable "kubernetes_helm_kube-sm_chart_version" {
  description = "Helm Kube Static Metrics Chart Version"
  default     = "2.8.4"
}

variable "kubernetes_helm_metrics-server_chart_name" {
  description = "Helm  Metrics Server Chart Name"
  default     = "stable/metrics-server"
}

variable "kubernetes_helm_metrics-server_chart_version" {
  description = "Helm  Metrics Server Chart Version"
  default     = "2.11.1"
}

variable "kubernetes_helm_ingress_chart_name" {
  description = "Helm Ingress controller Chart Name"
  default     = "stable/nginx-ingress"
}

variable "kubernetes_helm_ingress_chart_version" {
  description = "Helm Ingress Controller Chart Version"
  default = "1.36.3"
}

######
## Cert Manager
######
variable "kubernetes_helm_certmanager_chart_version" {
  description = "Helm Cert Manager chart version"
  default     = "1.0.1"
}
variable "kubernetes_helm_certmanager_chart_name" {
  description = "Helm  Cert Manager chart version"
  default     = "cert-manager"
}
######