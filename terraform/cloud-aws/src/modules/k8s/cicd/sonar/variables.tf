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

variable "kubernetes_helm_sonar_chart_version" {
  description = "Helm  Sonar operator chart version"
  default     = "4.0.1"
}

variable "kubernetes_helm_sonar_chart_name" {
  description = "Helm  Sonar chart name"
  default     = "stable/prometheus-operator"
}

variable "root_infra_domain" {
  description = "Infrastructure domain"
}



variable "enable_cicd" {
  description = "Enable cicd module installation"
  default = false
}
