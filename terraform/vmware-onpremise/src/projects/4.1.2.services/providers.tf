




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
    key = "vm-helm.tfstate"    
    acl = "bucket-owner-full-control"
  }
}


provider "kubernetes" {
  config_path    = "../../../../envs/admin.conf"
}


provider "helm" {
  kubernetes {
    config_path    = "../../../../envs/admin.conf"
  }
}
