###############################################################################
##### K8S Security ############################################################
###############################################################################
locals {
  count_k8s_security = var.enable_k8s_security ? 1 : 0
  count_keycloak = (var.enable_k8s_keycloak && var.enable_k8s_security) ? 1 : 0
}

data "aws_region" "current" {
  count = local.count_k8s_security
}

data "aws_caller_identity" "current" {
  count = local.count_k8s_security
}
data "aws_vpc" "primary" {
  tags = {
    Name = "${module.naming_convention.basenamevpc}${module.naming_convention.default_object_sequence_number}"
  }
}

#data "template_file" "helm_consul" {
 # count = local.count_k8s_security

#  template = file("${path.module}/templates/eks_consul.yaml")

#  vars = {
#    ENV               = var.env
#    ROOT_INFRA_DOMAIN = var.root_infra_domain
#  }
#}

data "template_file" "helm_vault" {
  count = local.count_k8s_security

  template = file("${path.module}/templates/eks_vault.yaml")

  vars = {
    AWS_REGION        = var.region
    KMS_KEY           = aws_kms_key.vault_kms_key[0].id
    IPADDR            = <<EOT
     - ${chomp(data.http.myip.body)}/30
%{ for ip in var.vault_ip_access}     - ${ip}
%{ endfor }
EOT
    INFRA_UNIT        = var.default_tags["Infra-Unit"]
    ENV                = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    DYNTABLE          = module.dynamodb_table_vault.name
    LOCALADDRES       = data.aws_vpc.primary.cidr_block
    PUBLIC            = var.vault_enable_public
  }
}

data "template_file" "getroot" {
  count = local.count_k8s_security

  template = file("${path.module}/templates/cluster-keys.json")

  depends_on = [null_resource.init_vault]
}

data "template_file" "vault-kms-policy" {
  count = local.count_k8s_security

  template = file("${path.module}/templates/vault_kms_policy.tpl")

  vars = {
    aws_account = data.aws_caller_identity.current[0].account_id
    env         = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    resource_prefix = var.default_tags["_Application"]
  }
}

data "template_file" "chart_values_keycloak" {

  template = file("${path.module}/templates/keycloak_config.yaml")

  vars = {
    ENV = var.default_tags["Infra-Unit"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
    KEYCLOAK_USER = "keycloak"
    KEYCLOAK_NAME = "keycloak"
    KEYCLOAK_PASSWORD = random_password.key_keycloak.result
    PG_PASSWORD = random_password.key_keycloak.result
    PG_USER = "keycloak"
    PG_DB = "keycloak"
  }
}

data "kubernetes_service" "vault_ingress" {
  depends_on = [null_resource.init_vault]
  count = local.count_k8s_security
  metadata {
    name      = "${var.default_tags["_Application"]}-eks-vault-${var.default_tags["_Environment"]}-ui"
    namespace = "addons"
  }
}

###Get public IP runner
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
//data "template_file" "helm_vault" {
//  template = file("${path.module}/templates/main.yaml")
//
//  vars = {
//    ENV   = var.env
//    KMSID = aws_kms_key.vault_kms_key.key_id
//  }
//}