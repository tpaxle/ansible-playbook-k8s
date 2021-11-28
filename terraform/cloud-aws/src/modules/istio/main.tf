###############################################################################
##### K8S LOGIN AKS ###########################################################
###############################################################################
#### 1. Login AKS
#### 2. Download istioctl
#### 3. Create elastic search
#### 4. Create kibana
#### 5. Create ingress
#### 6. Deletes

resource "null_resource" "login" {
  count = local.enable_k8s_istio
  triggers = {
    always_run = timestamp()
  }
  # ...
  provisioner "local-exec" {
    #when    = destroy
    command = "aws eks update-kubeconfig --region eu-west-2 --name ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]} --kubeconfig ${local.kubeconfig}"
  }
}

resource "null_resource" "download-istio" {
  count = local.enable_k8s_istio
  # ...
  provisioner "local-exec" {
    #when    = destroy
    command = "export ISTIO_VERSION=${var.istio_version} && curl -L https://istio.io/downloadIstio | sh -"
  }
  depends_on = [
    null_resource.login]
}

resource "null_resource" "install-istio" {
  count = local.enable_k8s_istio
  # ...
  provisioner "local-exec" {
    #when    = destroy
    command = "istio-${var.istio_version}/bin/istioctl --kubeconfig ${local.kubeconfig} ${local.istiocommand}"
  }
  depends_on = [
    null_resource.download-istio]
}

resource "time_sleep" "wait_180_seconds" {
  count = local.enable_k8s_istio

  depends_on = [null_resource.install-istio]

  create_duration = "180s"
}

resource "null_resource" "label-default-namespace" {
  count = local.enable_k8s_istio

  # ...
  provisioner "local-exec" {
    #when    = "destroy"
    command = "kubectl --kubeconfig ${local.kubeconfig} label namespace default istio-injection=enabled --overwrite"
  }
  depends_on = [
    time_sleep.wait_180_seconds
  ]
}

module "create_gateway_file" {
  source                 = "../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/gateway_rendered.yaml"
  source_template        = "${path.module}/templates/gateway.yaml"
  template_vars          = {
    ENV = var.default_tags["Infra-Unit"]
    ROOT_PUBLIC_DOMAIN = var.root_public_domain
  }

  execution_count = local.enable_k8s_istio
}

resource "null_resource" "create_gateway-1" {
  count = local.enable_k8s_istio
  # ...
  provisioner "local-exec" {
    #when    = "destroy"

    command = "kubectl --kubeconfig ${local.kubeconfig} apply -f ${path.module}/templates/gateway_rendered.yaml"
  }
  depends_on = [
    module.create_gateway_file.rendered_file,
    null_resource.label-default-namespace
  ]
}

#
#
#
module "create_sv_gateway_file" {
  source                 = "../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/gateway_sv_rendered.yaml"
  source_template        = "${path.module}/templates/gateway_sv.yaml"
  template_vars          = {
    ENV                = var.default_tags["Infra-Unit"]
    ROOT_PUBLIC_DOMAIN = var.root_public_domain
  }

  execution_count = local.enable_k8s_istio
}
resource "null_resource" "create_sv_gateway" {
  count = local.enable_k8s_istio

  # ...
  provisioner "local-exec" {
    #when    = "destroy"

    command = "kubectl --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube apply -f ${path.module}/templates/gateway_sv_rendered.yaml"
  }
  depends_on = [
    null_resource.label-default-namespace,
    module.create_sv_gateway_file.rendered_file
  ]
}

module "create_ingress_kiali" {
  source                 = "../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/ingress_kiali_rendered.yaml"
  source_template        = "${path.module}/templates/ingress_kiali.yaml"
  template_vars          = {
    INFRA-UNIT                = var.default_tags["Infra-Unit"]
    ENV               = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
  }

  execution_count = local.enable_k8s_istio
}

resource "null_resource" "kubectl_create_ingress_kiali" {
  count = local.enable_k8s_istio

  # ...
  provisioner "local-exec" {
    #when    = "destroy"

    command = "kubectl --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube apply -f ${path.module}/templates/ingress_kiali_rendered.yaml"
  }
  depends_on = [
    null_resource.label-default-namespace,
    module.create_ingress_kiali.rendered_file
  ]
}

#
#
#

resource "null_resource" "download-destroy-istio" {
  count = local.enable_k8s_istio
  # ...
  triggers = {
    istio_version = var.istio_version
  }

  provisioner "local-exec" {
    when = destroy
    command = "export ISTIO_VERSION=${self.triggers.istio_version} && curl -L https://istio.io/downloadIstio | sh -"
  }
  depends_on = [
    null_resource.login-destroy]
}

resource "null_resource" "login-destroy" {
  count = local.enable_k8s_istio
  # ...
  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
    kubeconfig = local.kubeconfig
  }
  provisioner "local-exec" {
    when = destroy
    command = "aws eks update-kubeconfig --region eu-west-2 --name ${self.triggers.resource_prefix}-eks-main-${self.triggers.env} --kubeconfig ${self.triggers.kubeconfig}"
  }
  depends_on = [
    null_resource.uninstall-istio]
}

resource "null_resource" "uninstall-istio" {
  count = local.enable_k8s_istio
  # ...
  triggers = { 
    istio_version = var.istio_version
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
    infra_unit = var.default_tags["Infra-Unit"]
    kube = local.kubeconfig    
    root = var.root_infra_domain        
  }
  
  provisioner "local-exec" {
    when = destroy
    command = "istio-${self.triggers.istio_version}/bin/istioctl --kubeconfig ${self.triggers.kube} manifest generate --set profile=demo --set addonComponents.grafana.enabled=false --set addonComponents.prometheus.enabled=false --set meshConfig.enablePrometheusMerge=true | kubectl delete --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube --ignore-not-found=true -f -"
  }

  depends_on = [
    null_resource.delete-istio-namespace
  ]
}

resource "null_resource" "delete-istio-namespace" {
  count = local.enable_k8s_istio
  # ...
  triggers = {
    istio_version = var.istio_version
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
    kube = local.kubeconfig    
  }  
  provisioner "local-exec" {
    when = destroy
    command = "kubectl delete --kubeconfig ${self.triggers.kube} namespace istio-system"
  }
}


//resource "kubernetes_namespace" "addons" {
//  metadata {
//    annotations = {
//      name = "addons"
//    }
//    #labels = {
//    #  istio-injection = "enabled"
//    #}
//    name = "addons"
//  }
//}