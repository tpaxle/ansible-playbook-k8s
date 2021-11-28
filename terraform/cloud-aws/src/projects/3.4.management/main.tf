module "m-vpn" {
  source                    = "../../modules/m-vpn"
  az_dns_vpn                  = var.az_dns_vpn
  default_tags                = var.default_tags
  mgmt_pfsense_dns_ip         = var.mgmt_pfsense_dns_ip
  mgmt_pfsense_image_id       = var.mgmt_pfsense_image_id
  region                      = var.region
  root_infra_domain           = var.root_infra_domain
  root_public_domain          = var.root_public_domain
  sg_mgmt_ssh_object_sequence = local.sg_mgmt_ssh_object_sequence
  subnet_zone_id              = var.subnet_vpn_zone_id
  env_folder_name             = var.env_folder_name
}