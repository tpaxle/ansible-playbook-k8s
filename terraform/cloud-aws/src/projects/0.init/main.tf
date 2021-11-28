data "aws_iam_policy" "ec2" {
  name     = "AmazonEC2FullAccess"
}

data "aws_caller_identity" "source" {
  provider = aws.source
}

data "aws_iam_policy_document" "assume_role" {
  provider = aws.source
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.source.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "assume_role" {
  name                = "terraform-iac"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = [data.aws_iam_policy.ec2.arn]
}
