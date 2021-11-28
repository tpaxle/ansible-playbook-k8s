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
  }
  backend "s3" {
    key = "vpc-new.tfstate"
    acl = "bucket-owner-full-control"
  }
}