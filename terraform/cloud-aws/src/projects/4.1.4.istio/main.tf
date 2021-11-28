module "istio" {
  source              = "../../modules/istio"
  default_tags        = var.default_tags
  region              = var.region
  root_infra_domain   = var.root_infra_domain
  root_public_domain  = var.root_public_domain
  enable_k8s_istio    = var.enable_k8s_istio
  istio_version       = var.istio_version
}