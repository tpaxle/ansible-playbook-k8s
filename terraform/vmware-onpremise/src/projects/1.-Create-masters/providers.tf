############
# Providers
############



provider "vsphere" {
  allow_unverified_ssl = true

  # Configuration options
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
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.0.2"
    }
  }

  backend "s3" {
    key = "1.vm-servers.tfstate"
    acl = "bucket-owner-full-control"
  }
}
