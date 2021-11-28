############
# Providers
############


provider "aws" {
  region = var.region
  #profile = "new-account"
}

##############
# Remote state
##############

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.67.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.6.1"
    }
  }
  backend "s3" {
    key = "eks.tfstate"
    acl = "bucket-owner-full-control"
  }
}


provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.main_cluster_auth.token
}


provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.main_cluster_auth.token
    load_config_file       = false
  }
}
