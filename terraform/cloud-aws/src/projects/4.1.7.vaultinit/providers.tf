provider "aws" {
  region = var.region
  version = "~> 3.6"

  assume_role {
    role_arn = var.role_arn
  }
}

terraform {
  required_version = "= 0.12.28"

  backend "s3" {
    key = "vault-init.tfstate"
  }
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.main_cluster_auth.token
  load_config_file       = false
}

provider "vault" {
  address = "http://${var.az_dns_vault}.${var.default_tags["Infra-Unit"]}.${var.root_public_domain}:8200"
  token   = data.kubernetes_secret.vault_info.data.secret-token
}
