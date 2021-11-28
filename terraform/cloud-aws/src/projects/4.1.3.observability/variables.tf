###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
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

variable "access_key"{}
variable "secret_key"{}

variable "kubernetes_helm_prometheusop_chart_version" {
  description = "Helm  Prometheus operator chart version"
  default     = "8.13.8"
}
variable "kubernetes_helm_prometheusop_chart_name" {
  description = "Helm  Thanos chart version"
  default     = "stable/prometheus-operator"
}

variable "enable_k8s_observability" {
  description = "Enable observability module installation"
  default = false
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation (observability is needed in case of this will be true)"
  default = false
}