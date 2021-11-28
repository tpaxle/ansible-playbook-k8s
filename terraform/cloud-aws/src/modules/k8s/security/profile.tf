//data "aws_iam_policy_document" "assume_role" {
//  statement {
//    effect  = "Allow"
//    actions = ["sts:AssumeRole"]
//
//    principals {
//      type        = "Service"
//      identifiers = ["ec2.amazonaws.com"]
//    }
//  }
//}
//
//data "aws_iam_policy_document" "vault-kms-unseal" {
//  statement {
//    sid       = "VaultKMSUnseal"
//    effect    = "Allow"
//    resources = ["*"]
//
//    actions = [
//      "kms:Encrypt",
//      "kms:Decrypt",
//      "kms:DescribeKey",
//    ]
//  }
//}
//
//resource "aws_iam_role" "vault-kms-unseal" {
//  name               = "${var.resource_prefix}-vault-kms-key-${var.env}"
//  assume_role_policy = data.aws_iam_policy_document.assume_role.json
//}
//
//resource "aws_iam_role_policy" "vault-kms-unseal" {
//  name   = "${var.resource_prefix}-Vault-KMS-Unseal-${var.env}"
//  role   = aws_iam_role.vault-kms-unseal.id
//  policy = data.aws_iam_policy_document.vault-kms-unseal.json
//}
//
//resource "aws_iam_instance_profile" "vault-kms-unseal" {
//  name = "${var.resource_prefix}-vault-kms-unseal-${var.env}"
//  role = aws_iam_role.vault-kms-unseal.name
//}
