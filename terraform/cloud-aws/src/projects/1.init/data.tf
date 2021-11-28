locals {
  cloudfront_log_bucket_object_sequence = "001"
  elb_log_bucket_object_sequence        = "002"
  r53_log_object_sequence               = "003"
  s3_log_object_sequence                = "004"
  flow_log_object_sequence              = "005"
  waf_log_object_sequence               = "006"
  cloudwatch_log_object_sequence        = "007"
  logs_object_sequence                  = "008"
}

data "aws_caller_identity" "current" {
}

data "template_file" "all-blue4sky-chain" {
  template = file("${var.envs_path}/tosecure/blue1sky/chain.pem")
}

data "template_file" "all-blue4sky-privkey" {
  template = file("${var.envs_path}/tosecure/blue1sky/privkey.pem")
}

data "template_file" "all-blue4sky-cert" {
  template = file("${var.envs_path}/tosecure/blue1sky/cert.pem")
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

data "template_file" "flow_log_bucket_policy_template" {
  template = file("templates/flow_log_bucket_policy.tpl")

  vars = {
    flow_log_bucket_arn = aws_s3_bucket.flow_log_bucket.arn
    current_account_id  = data.aws_caller_identity.current.account_id
  }
}
