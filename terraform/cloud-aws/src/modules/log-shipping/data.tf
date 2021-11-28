###############################################################################
##### ROLE CLOUDWATCH KINESIS LOG #############################################
###############################################################################

data "template_file" "cloudwatch_to_firehose_role_template" {
  template = file("${path.module}/templates/cloudwatch_to_firehose_role.tpl")

  vars = {
    region = var.region
  }
}

###############################################################################
##### Cloudwatch permissions to firehose ######################################
###############################################################################
data "template_file" "cloudwatch_to_firehose_policy_template" {
  template = file("${path.module}/templates/cloudwatch_to_firehose_policy.tpl")

  vars = {
    region             = var.region
    current_account_id = var.aws_account_id
    firehose_role_arn  = aws_iam_role.cloudwatch_to_firehose_role.arn
  }
}


###############################################################################
##### Permissiosns to write in cloudwatch #####################################
###############################################################################

### Allow the current user to add a Subscription Filter to CloudWatch
data "template_file" "cloudwatch_log_destination_policy_template" {
  template = file("${path.module}/templates/cloudwatch_log_destination_policy.tpl")

  vars = {
    current_account_id  = var.aws_account_id
    log_destination_arn = aws_cloudwatch_log_destination.cloudwatch_log_destination.arn
  }
}

###############################################################################
##### ROLE CLOUDWATCH LOG #####################################################
###############################################################################
data "template_file" "firehose_for_cloudwatch_logs_role_template" {
  template = file("${path.module}/templates/firehose_for_cloudwatch_logs_role.tpl")

  vars = {
    current_account_id = var.aws_account_id
  }
}
data "template_file" "firehose_for_cloudwatch_logs_policy_template" {
  template = file("${path.module}/templates/firehose_for_cloudwatch_logs_policy.tpl")

  vars = {
    cloudwatch_log_bucket_arn = var.s3_logs_arn
    firehose_stream_arn       = aws_kinesis_firehose_delivery_stream.cloudwatch_log_delivery_stream.arn
    cloudwatch_lambda_arn     = aws_lambda_function.cloudwatch_lambda.arn
  }
}

###############################################################################
##### ROLE CLOUDRAIL LOG ######################################################
###############################################################################
data "template_file" "cloudtrail_log_role_template" {
  template = file("${path.module}/templates/cloudtrail_log_role.tpl")
}
data "template_file" "cloudtrail_log_policy_template" {
  template = file("${path.module}/templates/cloudtrail_log_policy.tpl")
}


###############################################################################
##### ROLE LAMBDA LOG #########################################################
###############################################################################
data "template_file" "cloudwatch_lambda_role_template" {
  template = file("${path.module}/templates/cloudwatch_lambda_role.tpl")
}

data "template_file" "cloudwatch_lambda_policy_template" {
  template = file("${path.module}/templates/cloudwatch_lambda_policy.tpl")
}

###############################################################################
##### TOOLS CLOUDWATCH#########################################################
###############################################################################
data "archive_file" "cloudwatch_log_processor_zip" {
  type        = "zip"
  source_file = "${path.module}/files/cloudwatch_log_processor.py"
  output_path = "cloudwatch_log_processor.zip"
}

locals {
  count_cloudtrail = var.enable_cloudtrail ? 1 : 0
}