###########################
## CREATING ECR ###########
###########################
module "ecr" {
  source       = "../../modules/m-ecr"
  ecr_repository     = var.ecr_repository
  default_tags = var.default_tags
}

