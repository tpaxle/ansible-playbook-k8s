###############################################################################
##### K8S SERVICES ELK ########################################################
###############################################################################
#### 1. Login AKS
#### 2. Create Roles CRD
#### 3. Create elastic search
#### 4. Create kibana
#### 5. Create ingress
#### 6. Deletes


resource "null_resource" "login" {
  # ...
  count = local.count_k8s_elk
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    #when    = destroy
    command = "aws eks update-kubeconfig --region ${var.region} --name ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]} --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube"
  }
  depends_on = [var.elk_depends_on]
}

resource "null_resource" "create-roles" {
  # ...
  count = local.count_k8s_elk

  provisioner "local-exec" {
    #when    = destroy
    command = "kubectl apply  --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube  -f ${path.module}/templates/all-in-one.yaml"
  }
  depends_on = [null_resource.login]

}

##########ELK
module "create_elastic_search_file" {
  source                 = "../../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/elastic-search_rendered.yaml"
  source_template        = "${path.module}/templates/elastic-search.yaml"
  template_vars          = {
    ENV                  = var.default_tags["Infra-Unit"]
    ROOT_INFRA_DOMAIN    = var.root_infra_domain
  }
  execution_count = local.count_k8s_elk
}

resource "null_resource" "create-elastic" {
  # ...
  count = local.count_k8s_elk
  provisioner "local-exec" {
    #when    = destroy
    command = "kubectl apply --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube -f ${path.module}/templates/elastic-search_rendered.yaml"
  }
  depends_on = [null_resource.create-roles,
                module.create_elastic_search_file.rendered_file]
}


##########KIBANA
module "create_kibana_file" {
  source                 = "../../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/kibana_rendered.yaml"
  source_template        = "${path.module}/templates/kibana.yaml"
  template_vars          = {}
  execution_count = local.count_k8s_elk
}

resource "null_resource" "create-kibana" {
  # ...
  count = local.count_k8s_elk
  provisioner "local-exec" {
    #when    = destroy
    command = "kubectl apply --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube -f ${path.module}/templates/kibana_rendered.yaml"
  }
  depends_on = [null_resource.create-elastic,
                module.create_kibana_file.rendered_file]
}

##########INGRESS
module "create_ingress_file" {
  source                 = "../../utils/create-file-from-template"
  destination_file_path  = "${path.module}/templates/ingress_rendered.yaml"
  source_template        = "${path.module}/templates/ingress${local.istio_template_name}.yaml"
  template_vars          = {
    ENV                  = var.default_tags["Infra-Unit"]
    ROOT_INFRA_DOMAIN    = var.root_infra_domain
  }
  execution_count = local.count_k8s_elk
}

resource "null_resource" "create-ingress" {
  count = local.count_k8s_elk

  provisioner "local-exec" {
    #when    = destroy
    command = "kubectl apply --kubeconfig ${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}.kube -f ${path.module}/templates/ingress_rendered.yaml"
  }
  depends_on = [null_resource.create-kibana,
                module.create_kibana_file.rendered_file]
}


resource "null_resource" "login_destroy" {
  count = local.count_k8s_elk

  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
    region = var.region
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws eks update-kubeconfig --region ${self.triggers.region}  --name ${self.triggers.resource_prefix}-eks-main-${self.triggers.env} --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube"
  }
  depends_on = [null_resource.delete-ingress]
}

resource "null_resource" "delete-roles" {
  # ...
  count = local.count_k8s_elk
  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete  --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube  -f ${path.module}/templates/all-in-one.yaml"
  }
}

resource "null_resource" "delete-elastic" {
  count = local.count_k8s_elk
  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube -f ${path.module}/templates/elastic-search.yaml"
  }
  depends_on = [null_resource.delete-roles]
}

resource "null_resource" "delete-kibana" {
  count = local.count_k8s_elk
  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube -f ${path.module}/templates/kibana.yaml"
  }
  depends_on = [null_resource.delete-elastic]
}

resource "null_resource" "delete-ingress" {
  # ...
  count = local.count_k8s_elk
  triggers = {
    resource_prefix = var.default_tags["_Application"]
    env = var.default_tags["_Environment"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete --kubeconfig ${self.triggers.resource_prefix}-eks-main-${self.triggers.env}.kube -f ${path.module}/templates/ingress.yaml"
  }
  depends_on = [null_resource.delete-kibana]
}
