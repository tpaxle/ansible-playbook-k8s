
###############################################################################
##### SECURITY GROUP MASTER####################################################
###############################################################################

resource "aws_security_group" "eks_master" {
  name        = "${var.default_tags["_Application"]}-eks-master-${var.default_tags["_Environment"]}"
  description = "Cluster communication with worker nodes"
  vpc_id      = data.aws_vpc.primary.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.default_tags["_Application"]}-eks-master-${var.default_tags["_Environment"]}"
  }
}

###############################################################################
##### SECURITY GROUP WORKERS####################################################
###############################################################################

resource "aws_security_group" "eks_worker" {
  name        = "${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}"
  description = "Security group for all nodes in the cluster"
  vpc_id      = data.aws_vpc.primary.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = tomap({
      "Name" = "${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}",
      "kubernetes.io/cluster/${var.default_tags["_Application"]}-eks-main-${var.default_tags["_Environment"]}" = "owned",
  })
}

resource "aws_security_group_rule" "worker_access_self" {
  description       = "Allow worker self access"
  security_group_id = aws_security_group.eks_worker.id
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  type              = "ingress"
  self              = "true"
}

resource "aws_security_group_rule" "worker_access_from_master_443" {
  description              = "Allow worker access from masters"
  security_group_id        = aws_security_group.eks_worker.id
  source_security_group_id = aws_security_group.eks_worker.id
  from_port                = 443
  protocol                 = "tcp"
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_access_from_master_high_ports" {
  description              = "Allow worker access from masters"
  security_group_id        = aws_security_group.eks_worker.id
  source_security_group_id = aws_security_group.eks_master.id
  from_port                = 1025
  protocol                 = "tcp"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "ssh_access_from_vpc" {
  description       = "Allow VPC to workers on ssh"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_worker.id
  cidr_blocks       = [data.aws_vpc.primary.cidr_block]
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "worker_access_from_other_high_ports" {
  count             = length(var.eks_other_access_list) > 0 ? 1: 0
  description       = "Allow worker access from masters"
  security_group_id = aws_security_group.eks_worker.id
  cidr_blocks       = var.eks_other_access_list
  from_port         = 1025
  protocol          = "tcp"
  to_port           = 65535
  type              = "ingress"
}

resource "aws_security_group_rule" "workers_to_masters" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_master.id
  source_security_group_id = aws_security_group.eks_worker.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "api_access_from_vpc" {
  description       = "Allow VPC to access k8s API"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_master.id
  cidr_blocks       = [data.aws_vpc.primary.cidr_block]
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "api_access_from_other" {
  count             = length(var.eks_other_access_list) > 0 ? 1: 0
  description       = "Allow other locations to access k8s API"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_master.id
  cidr_blocks       = var.eks_other_access_list
  to_port           = 443
  type              = "ingress"
}