###############################################################################
##### K8S SERVICES  ###########################################################
###############################################################################

locals {
  count_k8s_observability = var.enable_k8s_observability ? 1 : 0
}

data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "main" {
  count = local.count_k8s_observability
  name = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
}

data "aws_eks_cluster_auth" "main_cluster_auth" {
  count = local.count_k8s_observability
  name = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
}


###############################################################################
##### K8S Obserbabiltiy  ######################################################
###############################################################################

data "template_file" "helm_prometheus" {
  count = local.count_k8s_observability

  template = file("${path.module}/templates/eks_prometheus_exporter.yaml")

  vars = {
    INFRA_UNIT        = var.default_tags["Infra-Unit"]
    ENV               = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    RESOURCE          = var.default_tags["_Application"]
  }
}

data "template_file" "helm_thanos" {
  count = local.count_k8s_observability

  template = file("${path.module}/templates/thanos.yaml")

  vars = {
    INFRA_UNIT        = var.default_tags["Infra-Unit"]
    ENV               = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    RESOURCE          = var.default_tags["_Application"]
    REGION            = var.region
    ACCESSKEY         = var.access_key
    ACCESSPASS        = var.secret_key
  }

  depends_on = [aws_s3_bucket.monitoring-storage]
}

data "template_file" "monitoring-storage-bucket-policy" {
  count = local.count_k8s_observability

  template = file("${path.module}/templates/monitoring_storage_bucket_policy.tpl")

  vars = {
    bucket_name       = aws_s3_bucket.monitoring-storage[0].id
    aws_account       = data.aws_caller_identity.current.account_id
    env               = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    resource_prefix   = var.default_tags["_Application"]
  }
}
