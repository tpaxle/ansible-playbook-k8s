



locals {
  vpc_object_sequence_number                 = "001"
  elb_log_bucket_object_sequence             = "002"
  private_subnets_rds_object_sequence_number = "002"
  private_subnets_eks_object_sequence_number = "003"
  private_subnets_ris_object_sequence_number = module.naming_convention.ris_object_sequence
  private_subnets_kfk_object_sequence_number = "005"
}


data "aws_acm_certificate" "cert_devops_root" {
  domain = "*.${var.root_public_domain}"
  most_recent = true  
}

data "aws_acm_certificate" "cert_devops" {
  domain = "*.${var.root_public_domain}"
  most_recent = true
}
