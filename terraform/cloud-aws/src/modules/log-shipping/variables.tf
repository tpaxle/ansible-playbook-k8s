###############################################################################
##### DEFAULT VARIABLES  ######################################################
###############################################################################

variable "default_tags" {
    description = "Default Tags"
    type        = map
}

###############################################################################
##### LOG OPTIONS #############################################################
###############################################################################



variable "aws_account_id" {
  description = "AWS account id"
}


variable "region" {
  description = "The AWS region"
}

variable "cloudwatch_log_groups" {
  default = []
  type    = list
}

variable "s3_cloudrail_id" {
    description = "Ide S3 bucket"
}

variable "s3_logs_arn" {
    description = "ID S3 bucket logs"
}

variable "enable_cloudtrail" {
    description = "Create cloudtrail event flag"
    default = false
}

variable "basenamelogs" {}
variable "basenamecwf" {}
variable "basenameclr" {}
variable "basenamecld" {}
variable "basenamekfd" {}
variable "basenamelambdafunction" {}
variable "baseiamrole" {}
variable "baseiampolicy" {}