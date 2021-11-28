###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "observability_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

variable "region" {
  description = "The AWS region"
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

variable "root_infra_domain" {
  description = "Infrastructure domain"
}

variable "root_public_domain" {
  description = "Infrastructure public domain"
}

variable "enable_k8s_observability" {
  description = "Enable observability module installation"
  default = false
}

variable "enable_k8s_istio" {
  description = "Enable istio module installation"
  default = false
}
