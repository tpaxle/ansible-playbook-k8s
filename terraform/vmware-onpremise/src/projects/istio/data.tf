locals {
  kubeconfig    = "../../../../envs/admin.conf"
  istiocommandlb  = "install --set profile=demo --set addonComponents.grafana.enabled=false --set addonComponents.prometheus.enabled=false --set meshConfig.enablePrometheusMerge=true  --set values.kiali.dashboard.grafanaInClusterURL='http://grafana.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}'  --set values.kiali.prometheusNamespace='monitoring' --set values.kiali.prometheusAddr='http://thanos.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}/' --set values.gateways.istio-ingressgateway.serviceAnnotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal\"=\"true\" --set values.gateways.istio-ingressgateway.serviceAnnotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-type\"=\"nlb\" --set values.kiali.service.annotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-type\"=\"nlb\" --set values.kiali.service.annotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal\"=\"true\" --set values.kiali.service.annotations.\"external-dns\\.alpha\\.kubernetes\\.io/hostname\"=\"kiali.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}\" --set values.kiali.service.type=\"LoadBalancer\""
  #istiocommand  = "install --set profile=demo --set addonComponents.grafana.enabled=false --set addonComponents.prometheus.enabled=false --set meshConfig.enablePrometheusMerge=true  --set values.kiali.dashboard.grafanaInClusterURL='http://grafana.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}'  --set values.kiali.prometheusNamespace='monitoring' --set values.kiali.prometheusAddr='http://thanos.${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}/' --set values.gateways.istio-ingressgateway.serviceAnnotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal\"=\"true\" --set values.gateways.istio-ingressgateway.serviceAnnotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-type\"=\"nlb\" "
istiocommand  = "install --set profile=demo --set addonComponents.grafana.enabled=false --set addonComponents.prometheus.enabled=false --set meshConfig.enablePrometheusMerge=true  --set values.gateways.istio-ingressgateway.serviceAnnotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal\"=\"true\" --set values.gateways.istio-ingressgateway.serviceAnnotations.\"service\\.beta\\.kubernetes\\.io/aws-load-balancer-type\"=\"nlb\" -y"  
  enable_k8s_istio = var.enable_k8s_istio ? 1 : 0
}


data "template_file" "helm_kiali" {
  count = local.enable_k8s_istio

  template = file("${path.module}/templates/kiali.values")

  vars = {
    INFRA_UNIT        = var.default_tags["Infra-Unit"]
    ENV                = var.default_tags["_Environment"]
    ROOT_INFRA_DOMAIN = var.root_infra_domain
  }
}

