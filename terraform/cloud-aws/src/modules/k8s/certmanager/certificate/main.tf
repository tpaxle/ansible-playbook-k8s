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



module "file_certificate_wildcard" {
  source                 = "../../../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/wildcard_certificate_rendered.yaml"
  source_template        = "${path.module}/templates/wildcard_certificate.yaml"
  template_vars          = {
    NAMECERT     = var.certficate_name
    COMMONNAME  = var.commonname
    ISSUERNAME  = var.issuername
  }
}

resource "null_resource" "kubectl_create_cert_wildcard" {
  count   = local.count_k8s_security

  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube  -f ${path.module}/templates/wildcard_certificate_rendered.yaml"
  }
  depends_on = [
    null_resource.login-security,
    module.file_certificate_wildcard.rendered_file]
}