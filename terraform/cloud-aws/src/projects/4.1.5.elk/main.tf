module "k8s-elk" {
  source              = "../../modules/k8s/elk"
  default_tags        = var.default_tags
  region              = var.region
  root_infra_domain   = var.root_infra_domain
  root_public_domain  = var.root_public_domain
  enable_k8s_elk      = var.enable_k8s_elk
  enable_k8s_istio    = var.enable_k8s_istio
}
