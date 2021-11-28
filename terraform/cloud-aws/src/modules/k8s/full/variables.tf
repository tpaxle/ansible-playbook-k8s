###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "role_arn" {
  description = "The assumed role ARN"
}

variable "region" {
  description = "The AWS region"
}

variable "root_infra_domain" {
  description = "Infrastructure root domain"
}

variable "root_public_domain" {
  description = "Infrastructure public domain"
}

variable "kubernetes_helm_dashboard_chart_name" {
  description = "Helm Dashboard Chart Name"
  default     = "stable/kubernetes-dashboard"
}

variable "kubernetes_helm_dashboard_chart_version" {
  description = "Helm Dashboard chart version"
  default     = "1.10.1"
}

variable "kubernetes_helm_ingress_chart_name" {
  description = "Helm Ingress controller Chart Name"
  default     = "stable/nginx-ingress"
}

variable "kubernetes_helm_ingress_chart_version" {
  description = "Helm Ingress Controller Chart Version"
  default     = "1.36.3"
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
variable "kubernetes_helm_externaldns_chart_name" {
  description = "Helm  External DNS chart name"
  default     = "stable/external-dns"
}
variable "kubernetes_helm_externaldns_chart_version" {
  description = "Helm  External DNS chart version"
  default     = "2.20.4"
}

variable "kubernetes_helm_prometheusop_chart_version" {
  description = "Helm  Prometheus operator chart version"
  default     = "8.13.8"
}
variable "kubernetes_helm_prometheusop_chart_name" {
  description = "Helm  Thanos chart version"
  default     = "stable/prometheus-operator"
}

variable "kubernetes_helm_vault_chart_version" {
  description = "Helm Consul chart version"
  default     = "0.7.0"
}
variable "kubernetes_helm_vault_chart_name" {
  description = "Helm  Thanos chart version"
  default     = "vault"
}

variable "access_key"{}
variable "secret_key"{}

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
########


######
## Keycloak
######
variable "kubernetes_helm_keycloak_chart_version" {
  description = "Helm Keycloak chart version"
  default     = "11.0.2"
}
variable "kubernetes_helm_keycloak_chart_name" {
  description = "Helm  Keycloak chart version"
  default     = "keycloak"
}
variable "enable_k8s_keycloak" {
  description = "Enable keycloak installation"
  default     = true
}
########
variable "enable_k8s_elk" {
  description = "Enable elk module installation"
  default = true
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = true
}

variable "enable_k8s_security" {
  description = "Enable security module installation"
  default     = true
}

variable "enable_k8s_observability" {
  description = "Enable observability module installation"
  default = true
}
