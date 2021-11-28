###############################################################################
######K8S AUTH config #########################################################
###############################################################################
resource "kubernetes_config_map" "aws_auth_configmap" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
- rolearn: ${aws_iam_role.eks_worker.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
- rolearn: ${aws_iam_role.eks_administrator.arn}
  username: kubectl-access-user
  groups:
    - system:masters
- rolearn: ${aws_iam_role.eks_operator.arn}
  username: operatoruser:{{SessionName}}
  groups:
    - admin
YAML
   mapUsers = <<YAML
- userarn: arn:aws:iam::585830602155:user/jenkins-platform
  username: jenkins-platform
  groups:
    - system:masters
- userarn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/jenkins-user
  username: jenkins-user
  groups:
    - system:masters
- userarn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/terraform
  username: terraform
  groups:
    - system:masters    
YAML
  }

  depends_on = [
    aws_autoscaling_group.eks_worker,
    aws_iam_role.eks_administrator,
  ]
}


###############################################################################
######K8S NAMESPACES###########################################################
###############################################################################

resource "kubernetes_namespace" "devops-ns" {
  metadata {
    annotations = {
      name = "devops-ns"
    }

    #labels = "${var.default_tags}"

    name = "devops-ns"
  }
  depends_on = [
    kubernetes_config_map.aws_auth_configmap
  ]
}
resource "kubernetes_namespace" "kaniko-ns" {
  metadata {
    annotations = {
      name = "kaniko-ns"
    }

    #labels = "${var.default_tags}"

    name = "kaniko-ns"
  }
  depends_on = [
    kubernetes_config_map.aws_auth_configmap
  ]
}

###############################################################################
######K8S SECRETS #############################################################
###############################################################################
resource "kubernetes_secret" "apm-default" {
  metadata {
    name = "apm-server-apm-token"
  }

  data = {
    secret-token = "8TQG8100SbtmJX52rlZ0Gm72"
  }

  type = "Opaque"
  depends_on  = [kubernetes_namespace.devops-ns]

}
resource "kubernetes_secret" "apm-devops" {
  metadata {
    name = "apm-server-apm-token"
    namespace = "devops-ns"
  }

  data = {
    secret-token = "ZDgzdnY3QVpQcWM4OVowcjI5RzV2OW5w"
  }

  type = "Opaque"
  depends_on  = [kubernetes_namespace.devops-ns]

}
resource "kubernetes_secret" "acr-secret-devops" {
  metadata {
    name = "acr-secret"
    namespace = "devops-ns"
  }
  data = {
    ".dockerconfigjson" = file("${path.module}/files/secret.json")
  }
  type = "kubernetes.io/dockerconfigjson"
  depends_on  = [kubernetes_namespace.devops-ns]

}

resource "kubernetes_secret" "acr-secret" {
  metadata {
    name = "acr-secret"
  }
  data = {
    ".dockerconfigjson" = file("${path.module}/files/secret.json")
  }

  type = "kubernetes.io/dockerconfigjson"
  depends_on = [
    kubernetes_config_map.aws_auth_configmap
  ]
}

resource "kubernetes_secret" "acr-secret-kaniko" {
  metadata {
    name = "acr-secret"
    namespace = "kaniko-ns"
  }
  data = {
    ".dockerconfigjson" = "${file("${path.module}/files/secret.json")}"
  }

  type = "kubernetes.io/dockerconfigjson"
  depends_on = [kubernetes_namespace.kaniko-ns]
}
resource "kubernetes_secret" "kaniko-registry-credentials" {
  metadata {
    name = "kaniko-registry-credentials"
    namespace = "kaniko-ns"
  }
  data = {
    ".dockerconfigjson" = "${file("${path.module}/files/kaniko-registry-credentials.json")}"
  }

  type = "kubernetes.io/dockerconfigjson"
  depends_on = [kubernetes_namespace.kaniko-ns]
}
