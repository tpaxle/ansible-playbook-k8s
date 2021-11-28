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
##### VPC CONFIGURATION #######################################################
###############################################################################

module "vpc" {
  source          = "../../modules/m-vpc/generic"
  object_sequence = local.vpc_object_sequence_number
  vpc_cidr_block  = var.vpc_cidr_block
  default_tags    = var.default_tags
  basenamevpc     = module.naming_convention.basenamevpc
}

###############################################################################
##### GATEWAYS CCONFIGURATION  ################################################
###############################################################################
module "vpc_igw" {
  source          = "../../modules/m-vpc/igw"
  object_sequence = local.vpc_object_sequence_number
  vpc_id          = module.vpc.vpc_id
  default_tags    = var.default_tags
  basenameigw     = module.naming_convention.basenameigw
}

module "vpc_natgw" {
  source          = "../../modules/m-vpc/natgw"
  aws_azs         = var.aws_azs
  object_sequence = local.vpc_object_sequence_number
  subnets_id      = module.subnet_public.subnets_ids
  default_tags    = var.default_tags
  basenameeip     = module.naming_convention.basenameeip
  basenamengw     = module.naming_convention.basenamengw
}

###############################################################################
##### SUBNETS CCONFIGURATION  #################################################
###############################################################################
################
# Public subnet
################

module "subnet_public" {
  source                  = "../../modules/m-vpc/subnet"
  object_sequence         = local.vpc_object_sequence_number
  list_subnets            = var.public_subnets
  public_subnets_tags     = var.public_subnets_tags
  aws_azs                 = var.aws_azs
  subnet_sufix            = "public-subnet"
  map_public_ip_on_launch = true
  vpc_id                  = module.vpc.vpc_id
  default_tags            = var.default_tags
  basenamesnt             = module.naming_convention.basenamesnt
}

#################
# Private subnet
#################

module "private_subnets_eks" {
  source                  = "../../modules/m-vpc/subnet"
  object_sequence         = local.private_subnets_eks_object_sequence_number
  list_subnets            = var.private_subnets_eks
  public_subnets_tags     = var.private_subnets_tags_eks
  aws_azs                 = var.aws_azs
  subnet_sufix            = "prveks-subnet"
  map_public_ip_on_launch = false
  vpc_id                  = module.vpc.vpc_id
  default_tags            = var.default_tags
  basenamesnt             = module.naming_convention.basenamesnt
}


###############################################################################
##### ROUTES CCONFIGURATION  ##################################################
###############################################################################

################
# Public routes
################
module "rt_public" {
  source          = "../../modules/m-vpc/rt/generic"
  object_sequence = local.vpc_object_sequence_number
  public_rt_tags  = var.public_rt_tags
  aws_azs         = var.aws_azs
  subnets_id      = module.subnet_public.subnets_ids
  vpc_id          = module.vpc.vpc_id
  default_tags    = var.default_tags
  basenamertb     = module.naming_convention.basenamertb
  igw_connections      = [module.vpc_igw.vpc_igw_id]
}


#####################
# Data Private routes
#####################

module "rt_private_eks" {
  source          = "../../modules/m-vpc/rt/generic"
  object_sequence = local.private_subnets_eks_object_sequence_number
  public_rt_tags  = var.private_rt_tags_eks
  aws_azs         = var.aws_azs
  subnets_id      = module.private_subnets_eks.subnets_ids
  vpc_id          = module.vpc.vpc_id
  default_tags    = var.default_tags
  basenamertb     = module.naming_convention.basenamertb
  natgw_connections     = module.vpc_natgw.vpc_ngw_id
}



###############################################################################
##### LOAD BALANCER CONFIGURATION #############################################
###############################################################################
module "lb_nginx" {
  source          = "../..//modules/m-ec2/lb"
  object_sequence = local.vpc_object_sequence_number
  subnets         = module.subnet_public.subnets_ids
  bucketname      = "${module.naming_convention.basenamebucket}002"
  default_tags    = var.default_tags
  securitygroups  = [module.sg_lb_nginx.id]
  certificatearn  = data.aws_acm_certificate.cert_devops_root.arn
  vpcid           = module.vpc.vpc_id
  basenamenlb     = module.naming_convention.basenamenlb
}

