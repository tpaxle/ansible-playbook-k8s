###############################################################################
##### K8S SERVICES  ###########################################################
###############################################################################

data "aws_eks_cluster" "main" {
  name = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
}

data "aws_eks_cluster_auth" "main_cluster_auth" {
  name = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
}