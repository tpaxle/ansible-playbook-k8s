###############################################################################
##### NAMING CONVENTION CONFIGURATION IMPORT ##################################
###############################################################################

module "naming_convention" {
  source                       = "../..//modules/naming-convention"
  region                       = var.region
  entity                       = var.default_tags["_Entity"]
  environment                  = var.default_tags["_Environment"]
  geo_region                   = var.default_tags["_GeoRegion"]
  application                  = var.default_tags["_Application"]
  naming_convention_definition = var.naming_convention_definition
}

###############################################################################
###############################################################################
###############################################################################

###############################################################################
##### Route53 Subdomains and their certificates ###############################
###############################################################################

module "dns_base_env_infra" {
  source           = "../../modules/dns-base"
  object_sequence  = module.naming_convention.default_object_sequence_number
  domain_prefix    = var.default_tags["Infra-Unit"]
  root_domain_name = var.root_infra_domain
  tag_zone_type    = "env-infra"
  tag_infra_unit   = "gshareddns"
  default_tags     = var.default_tags
  vpc_id           = data.aws_vpc.primary.id
  basenamedns      = module.naming_convention.basenamedns
}

