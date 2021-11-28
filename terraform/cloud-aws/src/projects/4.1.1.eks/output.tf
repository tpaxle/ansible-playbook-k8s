locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.main.endpoint}
    certificate-authority-data: ${aws_eks_cluster.main.certificate_authority.0.data}
  name: eks-${var.default_tags["_Environment"]}
contexts:
- context:
    cluster: eks-${var.default_tags["_Environment"]}
    user: eks-${var.default_tags["_Environment"]}
  name: eks-${var.default_tags["_Environment"]}
current-context: eks-${var.default_tags["_Environment"]}
kind: Config
preferences: {}
users:
- name: eks-${var.default_tags["_Environment"]}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.main.id}"
        - -r
        - ${aws_iam_role.eks_administrator.arn}        
KUBECONFIG
  options = <<MANAGEMENT
----------------------------------------------------
---4.1 Kubernetes ----------------------------------
----------------------------------------------------
IAM Roles:
- ${var.default_tags["_Application"]}-eks-master-${var.default_tags["_Environment"]}
- ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}
- ${var.default_tags["_Application"]}-eks-operator-${var.default_tags["_Environment"]}
- ${var.default_tags["_Application"]}-eks-administrator-${var.default_tags["_Environment"]}
- ${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}
role_eks_worker

EKS Created: (${aws_eks_cluster.main.id})
  Endpoint:   ${aws_eks_cluster.main.endpoint}
  Version:    ${aws_eks_cluster.main.version}

Namespaces:
  devops-ns

Secrets:
  ecr: 
  vault:
MANAGEMENT
}

output "kubeconfig" {
  value = local.kubeconfig
}


output "toString" {
  value = local.options
}
