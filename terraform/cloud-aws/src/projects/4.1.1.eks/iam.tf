###############################################################################
##### ROLES FOR AKS - EKS-Master###############################################
###############################################################################
resource "aws_iam_role" "eks_master" {
  name               = "${var.default_tags["_Application"]}-eks-master-${var.default_tags["_Environment"]}"
  assume_role_policy = data.template_file.eks_master_iam_role.rendered
}

resource "aws_iam_role_policy_attachment" "eks_master_AmazonEKSClusterPolicy" {
  policy_arn        = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role              = aws_iam_role.eks_master.name
}

resource "aws_iam_role_policy_attachment" "eks_master_AmazonEKSServicePolicy" {
  policy_arn        = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role              = aws_iam_role.eks_master.name
}

###############################################################################
##### ROLES FOR AKS - EKS-CI###################################################
###############################################################################


#resource "aws_iam_role" "eks_ci" {
#  name               = "${var.resource_prefix}-circleci-eks-${var.env}"
#  assume_role_policy = data.template_file.eks_ci_iam_role.rendered
#}

#resource "aws_iam_policy" "eks_ci_policy" {
#  name              = "${var.resource_prefix}-eks-ci-policy-${var.env}"
#  policy            = data.template_file.eks_ci_role_policy.rendered
#}

#resource "aws_iam_role_policy_attachment" "eks_ci" {
#  policy_arn        = aws_iam_policy.eks_ci_policy.arn
#  role              = aws_iam_role.eks_ci.name
#}

###############################################################################
##### ROLES FOR AKS - OPERATOR#################################################
###############################################################################

resource "aws_iam_role" "eks_operator" {
  name               = "${var.default_tags["_Application"]}-eks-operator-${var.default_tags["_Environment"]}"
  assume_role_policy = data.template_file.eks_operator_iam_role.rendered
}


resource "aws_iam_role" "eks_administrator" {
  name               = "${var.default_tags["_Application"]}-eks-administrator-${var.default_tags["_Environment"]}"
  assume_role_policy = data.template_file.eks_administrator_iam_role.rendered
}

resource "aws_iam_role" "eks_worker" {
  name               = "${var.default_tags["_Application"]}-eks-worker-${var.default_tags["_Environment"]}"
  assume_role_policy = data.template_file.eks_worker_iam_role.rendered
}

###############################################################################
##### ROLES FOR AKS - POLICIES#################################################
###############################################################################
resource "aws_iam_policy" "eks_worker_policy" {
  name   = "${var.default_tags["_Application"]}-eks-worker-policy-${var.default_tags["_Environment"]}"
  policy = data.template_file.eks_worker_role_policy.rendered
}

resource "aws_iam_role_policy_attachment" "eks_worker_custom" {
  policy_arn = aws_iam_policy.eks_worker_policy.arn
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "eks_worker_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "eks_worker_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "eks_worker_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker.name
}
