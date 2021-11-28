###############################################################################
##### NAMING CONVENTION CONFIGURATION IMPORT ##################################
###############################################################################

module "naming_convention" {
  source                       = "../../modules/naming-convention"
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

module "log_shipping" {
  source                = "../../modules/log-shipping"
  s3_cloudrail_id       = data.aws_s3_bucket.s3_clourail.id
  s3_logs_arn           = data.aws_s3_bucket.s3_logs.arn
  region                = var.region
  cloudwatch_log_groups = var.cloudwatch_log_groups
  aws_account_id        = data.aws_caller_identity.current.account_id
  default_tags          = var.default_tags
  baseiampolicy         = module.naming_convention.baseiampolicy
  baseiamrole           = module.naming_convention.baseiamrole
  basenamecld           = module.naming_convention.basenamecld
  basenameclr           = module.naming_convention.basenameclr
  basenamecwf           = module.naming_convention.basenamecwf
  basenamekfd           = module.naming_convention.basenamekfd
  basenamelambdafunction  = module.naming_convention.basenamelambdafunction
  basenamelogs          = module.naming_convention.basenamelogs
  enable_cloudtrail      = var.enable_cloudtrail
}

