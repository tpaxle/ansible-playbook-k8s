locals {
  options = <<VPC_CONFIG
----------------------------------------------------
---2. VPC And Netwoks ------------------------------
----------------------------------------------------
VPC Created: (${module.vpc.vpc_id})
  vpc_cidr: ${module.vpc.vpc_cidr}
  ARN:      ${module.vpc.arn}
  SUBNETS:
  --------------------
  |  Public Subnets:   |
  -----------------------------------------------
  |${module.subnet_public.subnets_ids[0]}  |  ${module.subnet_public.cidr_block[0]}
  |${module.subnet_public.subnets_ids[1]}  |  ${module.subnet_public.cidr_block[1]}
  |${module.subnet_public.subnets_ids[2]}  |  ${module.subnet_public.cidr_block[2]}
  -------------------
  |  EKS Subnets:   |
  -----------------------------------------------
  |${module.private_subnets_eks.subnets_ids[0]}  |  ${module.private_subnets_eks.cidr_block[0]}
  |${module.private_subnets_eks.subnets_ids[1]}  |  ${module.private_subnets_eks.cidr_block[1]}
  |${module.private_subnets_eks.subnets_ids[2]}  |  ${module.private_subnets_eks.cidr_block[2]}
  -------------------


Internet Gateway: ${module.vpc_igw.vpc_igw_id}


VPC_CONFIG
}

output "toString" {
  value = local.options
}
