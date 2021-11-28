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

###############################################################################
######EKS CLUSTER  ############################################################
###############################################################################

resource "aws_eks_cluster" "main" {
  name     = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
  role_arn = aws_iam_role.eks_master.arn
  version  = var.eks_version

  vpc_config {
    security_group_ids      = [aws_security_group.eks_master.id]
    subnet_ids              = tolist(data.aws_subnet_ids.private.ids)
    endpoint_private_access = true
    endpoint_public_access  = true
  }
  tags = merge(
      tomap(
       { "Name" = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
       }
      ),
      "${var.default_tags}"
    )

  enabled_cluster_log_types = ["authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_master_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_master_AmazonEKSServicePolicy,
  ]
}

resource "aws_iam_instance_profile" "eks_worker" {
  name = "${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}"
  role = aws_iam_role.eks_worker.name
}

locals {
  worker_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.main.endpoint}' --b64-cluster-ca '${aws_eks_cluster.main.certificate_authority.0.data}' '${aws_eks_cluster.main.id}'
USERDATA

  monitoring_worker_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.main.endpoint}' --b64-cluster-ca '${aws_eks_cluster.main.certificate_authority.0.data}' --kubelet-extra-args '--register-with-taints=monitoring-node=true:NoSchedule --node-labels=monitoring-node=true' '${aws_eks_cluster.main.id}'
USERDATA
}


###############################################################################
######EKS KLUSTER  ############################################################
###############################################################################

resource "aws_key_pair" "k8s" {
  key_name   = "${var.default_tags["_Application"]}-eks-key-${var.default_tags["_Environment"]}"
  public_key = file("${var.envs_path}/${var.env_folder_name}/k8s-ssh-${var.default_tags["_Environment"]}.pub")
}

resource "aws_launch_configuration" "eks_monitoring_worker" {
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.eks_worker.name
  image_id                    = data.aws_ami.eks_worker.id
  instance_type               = var.eks_monitoring_worker_instance_type
  name_prefix                 = "${var.default_tags["_Application"]}-eks-monitoring-worker-${var.default_tags["_Environment"]}"
  security_groups             = [aws_security_group.eks_worker.id]
  key_name                    = aws_key_pair.k8s.key_name
  user_data_base64            = base64encode(local.monitoring_worker_userdata)

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 500
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "eks_worker" {
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.eks_worker.name
  image_id                    = data.aws_ami.eks_worker.id
  instance_type               = var.eks_worker_instance_type
  name_prefix                 = "${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}"
  security_groups             = [aws_security_group.eks_worker.id]
  key_name                    = aws_key_pair.k8s.key_name
  user_data_base64            = base64encode(local.worker_userdata)

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 500
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_worker" {
  desired_capacity     = var.eks_worker_desired
  launch_configuration = aws_launch_configuration.eks_worker.id
  max_size             = var.eks_worker_max
  min_size             = var.eks_worker_min
  name                 = "${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}"
  vpc_zone_identifier  = tolist(data.aws_subnet_ids.private.ids)

  tag {
    key                 = "Name"
    value               = "${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${aws_eks_cluster.main.id}"
    value               = "owned"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "eks_monitoring_worker" {
  desired_capacity     = "1"
  launch_configuration = aws_launch_configuration.eks_monitoring_worker.id
  max_size             = "2"
  min_size             = "0"
  name                 = "${var.default_tags["_Application"]}-eks-monitoring-worker-${var.default_tags["_Environment"]}"
  vpc_zone_identifier  = tolist(data.aws_subnet_ids.private.ids)

  tag {
    key                 = "Name"
    value               = "${var.default_tags["_Application"]}-eks-monitoring-worker-${var.default_tags["_Environment"]}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${aws_eks_cluster.main.id}"
    value               = "owned"
    propagate_at_launch = true
  }
}


###############################################################################
######EKS LOGS ################################################################
###############################################################################

#resource "aws_cloudwatch_log_subscription_filter" "cloudwatch_subscription" {
#  name            = "${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}"
#  log_group_name  = "/aws/eks/${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}/cluster"
  #destination_arn = "${data.aws_cloudwatch_log_group.kinesis_s3_logs.arn}"
#  destination_arn =  "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:destination:${module.naming_convention.basenamecld}${module.naming_convention.default_object_sequence_number}"
#  filter_pattern  = ""
#  distribution    = "ByLogStream"
#}
#arn:aws:logs:eu-west-2:011706625149:destination:sdid1aldcldglobilcsec001
