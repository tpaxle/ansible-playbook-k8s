module "enable_github" {
  source                                = "../../../modules/vault/github"
  github_adminteam      = var.github_adminteam
  github_organization   = var.github_organization
}
module "enable_pki" {
  source                                = "../../../modules/vault/pki"
  default_tags  = var.default_tags
  domain_name   = var.root_infra_domain
  pki_path      = "pki_terraform"
  pki_role_name = "role_ca_cert"
}

module "enable_kv"{
  source                                = "../../../modules/vault/kv_secrets"
  pki_type      = "kv"
  pki_path      = "secretsv1"
  default_path  = "ci/sandbox"
  keys_file     = "../../../envs/tosecure/example_vault.json"
  default_tags  = var.default_tags
}
module "create_ci_token"{
  source        = "../../../modules/vault/token"
  policies      = ["pv-admin"]

}

module "create_certmanager_issuer"{
  source        = "../../../modules/k8s/certmanager/issuer"
  default_tags  = var.default_tags
  pki_vault_path = "pki_terraform/sign/role_ca_cert"
}

module "create_certificate_wildcard"{
  source        = "../../../modules/k8s/certmanager/certificate"
  default_tags = var.default_tags
  commonname  = "*.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}"
  certficate_name =  "wildcard-${var.default_tags["_Environment"]}-tls"
}