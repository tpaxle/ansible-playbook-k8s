
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "primary" {
  tags = {
    Name = "${module.naming_convention.basenamevpc}${module.naming_convention.default_object_sequence_number}"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.primary.id

  tags = {
    zone = "prveks-subnet"
  }
}

data "aws_route53_zone" "environment_subdomain" {
  name         = "${var.default_tags["Infra-Unit"]}.${var.root_infra_domain}."
  private_zone = true

  tags = {
    DNS       = "gshareddns"
  }
}

#data "template_file" "eks_ci_iam_role" {
#  template = file("templates/eks_ci_iam_role.json.tpl")
#
#  vars = {
#    circleci_instance_profile_role       = var.circleci_instance_profile_role
#    circleci_nomad_instance_profile_role = var.circleci_nomad_instance_profile_role
#  }
#}

data "template_file" "eks_administrator_iam_role" {
  template = file("templates/eks_administrator_iam_role.json.tpl")

  vars = {
    account = data.aws_caller_identity.current.account_id
    env     = var.default_tags["_Environment"]
    resource_prefix = var.default_tags["_Application"]
  }
}

data "template_file" "eks_operator_iam_role" {
  template = file("templates/eks_operator_iam_role.json.tpl")

  vars = {
    account = data.aws_caller_identity.current.account_id
    env     = var.default_tags["_Environment"]
    resource_prefix = var.default_tags["_Application"]
  }
}

data "template_file" "eks_master_iam_role" {
  template = file("templates/eks_master_iam_role.json.tpl")
}

data "template_file" "eks_worker_iam_role" {
  template = file("templates/eks_worker_iam_role.json.tpl")
}

data "template_file" "eks_worker_role_policy" {
  template = file("templates/eks_worker_iam_policy.json.tpl")
}

data "template_file" "eks_ci_role_policy" {
  template = file("templates/eks_ci_iam_policy.json.tpl")
}

data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.main.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

data "aws_eks_cluster_auth" "main_cluster_auth" {
  name = aws_eks_cluster.main.id
}
