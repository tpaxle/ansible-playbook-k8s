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

variable "kubernetes_helm_nexus_chart_version" {
  description = "Helm  Nexus operator chart version"
  default     = "2.8.0"
}

variable "kubernetes_helm_nexus_chart_name" {
  description = "Helm  Nexus chart name"
  default     = "sonatype-nexus"
}

variable "root_infra_domain" {
  description = "Infrastructure domain"
}



variable "enable_cicd" {
  description = "Enable cicd module installation"
  default = false
}
