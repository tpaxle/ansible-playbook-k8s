############
# Providers
############

provider "aws" {
  alias   = "source"
  profile = "source"
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
    key = "01.ssoo.tfstate"
    acl = "bucket-owner-full-control"
  }
}