###############################################################################
##### CREATE ISSUER######################### ##################################
###############################################################################
#### Login
#### Create template
#### Kubectl apply

resource "null_resource" "login-security" {
  # ...
  count             = local.count_k8s_security

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    #when    = destroy
    command = "aws eks update-kubeconfig --name ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]} --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube"
  }
  depends_on = [var.login_depends_on]
}

#########################################################
##### CREATE ISSUER ##################################
###############################################################################
module "file_issuer_vault" {
  source                 = "../../../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/certmanager-issuer-vault-rendered.yaml"
  source_template        = "${path.module}/templates/certmanager-issuer-vault.yaml"
  template_vars          = {
    ENV = var.default_tags["_Environment"]
    PATH  = var.pki_vault_path
    resource_prefix = var.default_tags["_Application"]
  }
  execution_count = local.count_k8s_security

}

resource "null_resource" "kubectl_apply_issuer" {
  count = local.count_k8s_security

  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  }

  provisioner "local-exec" {
    #when    = "destroy"
    command = "kubectl apply --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube -f ${path.module}/templates/certmanager-issuer-vault-rendered.yaml"
  }
  depends_on = [
    module.file_issuer_vault.rendered_file,
    null_resource.login-security,
  ]
}