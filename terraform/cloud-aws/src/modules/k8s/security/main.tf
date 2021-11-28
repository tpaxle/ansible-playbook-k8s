###############################################################################
##### K8S Security ############################################################
###############################################################################
#### 1. Vault
#### 2. Certmanager
#### 3. KeyCloak

###############################################################################
##### NAMING CONVENTION CONFIGURATION IMPORT ##################################
###############################################################################

module "naming_convention" {
  source                       = "../../naming-convention"
  region                       = var.region
  entity                       = var.default_tags["_Entity"]
  environment                  = var.default_tags["_Environment"]
  geo_region                   = var.default_tags["_GeoRegion"]
  application                  = var.default_tags["_Application"]
  naming_convention_definition = var.naming_convention_definition
}

###Deprecated
#resource "helm_release" "stable-consul" {
#  count             = local.count_k8s_security
#  name              = "${var.resource_prefix}-eks-consul-${var.env}"
#  chart             = var.kubernetes_helm_consul_chart_name
#  version           = var.kubernetes_helm_consul_chart_version
#  force_update      = "true"
#  namespace         = "addons"
#  create_namespace  = "true"
#  repository        = "https://helm.releases.hashicorp.com"
  # create_namespace  = true
#  set {
#    name  = "global.name"
#    value = "consul"
#  }
#  values            = [data.template_file.helm_consul[0].rendered]#
#
#  depends_on        = [var.security_depends_on]
#}
#resource "null_resource" "delete-consul-pvc" {
#  count     = local.count_k8s_security#
#
#  triggers = {
#    resource_prefix = var.resource_prefix
#    env = var.env
#  }#

#  provisioner "local-exec" {
#    when    = destroy
#    command = "kubectl delete --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube -n addons pvc data-addons-consul-server-0 data-addons-consul-server-1"
#  }
#}

resource "random_password" "key_keycloak" {
  length = 16
  special = false
}

resource "null_resource" "login-security" {
  # ...
  count             = local.count_k8s_security

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    #when    = destroy
    command = "aws eks update-kubeconfig --region eu-west-2 --name ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]} --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube"
  }
  depends_on = [var.login_depends_on]
}



module "dynamodb_table_vault" {
  source              = "../../databases/dynamodb/table"
  name                = "${var.default_tags["_Environment"]}-vault-data"
  read_capacity       = 10
  write_capacity      = 10

  default_tags        =   var.default_tags
}

resource "helm_release" "stable-vault" {
  count        = local.count_k8s_security
  name         = "${var.default_tags["_Application"]}-eks-vault-${var.default_tags["_Environment"]}"
  chart        = var.kubernetes_helm_vault_chart_name
  version      = var.kubernetes_helm_vault_chart_version
  wait         = false
  force_update = "true"
  namespace    = "addons"
  repository   = "https://helm.releases.hashicorp.com"

  values     = [data.template_file.helm_vault[0].rendered]
  #depends_on = [helm_release.stable-consul]
}

resource "aws_kms_key" "vault_kms_key" {
  count       = local.count_k8s_security
  description = "${var.default_tags["_Application"]}-vault-kms-key-${var.default_tags["_Environment"]}"
  policy      = data.template_file.vault-kms-policy[0].rendered
}

resource "time_sleep" "wait_180_seconds" {
  count           = local.count_k8s_security
  depends_on      = [helm_release.stable-vault, null_resource.login-security, aws_kms_key.vault_kms_key]

  create_duration = "60s"
}

###Init vault
resource "null_resource" "init_vault" {
  count       = local.count_k8s_security

  provisioner "local-exec" {
    command = "kubectl exec -it  ${var.default_tags["_Application"]}-eks-vault-${var.default_tags["_Environment"]}-0 -n addons --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube  -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ${path.module}/templates/cluster-keys.json"
  }
  depends_on = [time_sleep.wait_180_seconds]
}

###Unseal (Pending to migrate)
resource "kubernetes_secret" "vault-token" {
  count   = local.count_k8s_security
  metadata {
    name = "vault-root-token"
  }

  data = {
    secret-token = jsondecode(data.template_file.getroot[0].rendered).root_token
    key_keycloak = random_password.key_keycloak.result
    //unseal-key   = jsondecode(data.template_file.getroot.rendered).unseal_keys_hex[0]
  }

  type = "Opaque"

}

resource "null_resource" "login_destroy-security" {
  count = local.count_k8s_security

  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws eks update-kubeconfig  --region eu-west-2 --name ${self.triggers.resource_prefix}-eks-main-${self.triggers.env} --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube"
  }
#  depends_on = [null_resource.delete-consul-pvc]
}


resource "kubernetes_secret" "secret-vault-certmanager" {
  count = local.count_k8s_security

  metadata {
    name = "vault-root-token"
    namespace = "addons"
  }

  data = {
    secret-token = jsondecode(data.template_file.getroot[0].rendered).root_token
    key_keycloak = random_password.key_keycloak.result
  }

  type = "Opaque"
}

######################################################################################################################################################
######################  KEYCLOAK  ##################################################################################################
######################################################################################################################################################

resource "helm_release" "keycloak-chart" {
  count        = local.count_keycloak
  name         = "${var.default_tags["_Application"]}-eks-keycloak-${var.default_tags["_Environment"]}"
  chart        = var.kubernetes_helm_keycloak_chart_name
  version      = var.kubernetes_helm_keycloak_chart_version
  force_update = "true"
  namespace    = "addons"
  repository   = "https://codecentric.github.io/helm-charts"
  #create_namespace  = true

  values     = [data.template_file.chart_values_keycloak.rendered]
  depends_on = [kubernetes_secret.secret-vault-certmanager,null_resource.delete_pvc]
}

resource "null_resource" "delete_pvc" {
  count       = local.count_keycloak

  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  } 

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete pvc data-${self.triggers.resource_prefix}-eks-keycloak-${self.triggers.env}-postgresql-0 -n addons --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube --ignore-not-found=true"
  }
}

resource "null_resource" "delete-login-security" {
  count             = local.count_k8s_security

  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  } 

  provisioner "local-exec" {
    when    = destroy
    command = "aws eks update-kubeconfig --region eu-west-2 --name ${self.triggers.resource_prefix}-eks-main-${self.triggers.env} --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube"
  }
  depends_on = [helm_release.keycloak-chart[0]]
}

