###############################################################################
##### ROLE CLOUDWATCH FIREHOSE LOG ############################################
###############################################################################


resource "aws_iam_role" "firehose_for_cloudwatch_logs" {
  #name = "${var.resource_prefix}-firehose-cloudwatch-logs-${var.env}"
  name                  = "${var.baseiamrole}002"
  assume_role_policy    = data.template_file.firehose_for_cloudwatch_logs_role_template.rendered
  
  tags = merge(
      tomap( {
        "Name" = "${var.baseiamrole}002",
        "App" =  "Iam role",
        "Scope" = "firehose_for_cloudwatch_logs"
      }),
      "${var.default_tags}"
    )
}

resource "aws_iam_role_policy" "firehose_for_cloudwatch_logs" {
  name      =   "${var.baseiampolicy}002"
  role      =   aws_iam_role.firehose_for_cloudwatch_logs.name
  policy    =   data.template_file.firehose_for_cloudwatch_logs_policy_template.rendered
}

###############################################################################
##### ROLE CLOUDWATCH KINESIS LOG #############################################
###############################################################################

resource "aws_iam_role" "cloudwatch_to_firehose_role" {
  #name = "${var.resource_prefix}-cloudwatch-to-firehose-${var.env}"
  name                  = "${var.baseiamrole}003"
  assume_role_policy    = data.template_file.cloudwatch_to_firehose_role_template.rendered

  tags = merge(
      tomap(
        {
        "Name" = "${var.baseiamrole}003",
        "App" = "Iam role",
        "Scope" = "cloudwatch_to_firehose_role"
        }

      ),
      "${var.default_tags}"
    )
}

resource "aws_iam_role_policy" "cloudwatch_to_firehose_policy" {
  #name = "${var.resource_prefix}-cloudwatch-to-firehose-${var.env}"
  name           = "${var.baseiampolicy}003"
  role           = aws_iam_role.cloudwatch_to_firehose_role.name
  policy         = data.template_file.cloudwatch_to_firehose_policy_template.rendered
}

##### Permissiosns to write in cloudwatch #####################################

resource "aws_cloudwatch_log_destination_policy" "cloudwatch_log_destination_policy" {
  destination_name = aws_cloudwatch_log_destination.cloudwatch_log_destination.name
  access_policy = data.template_file.cloudwatch_log_destination_policy_template.rendered
}

###############################################################################
##### ROLE LAMBDA LOG #########################################################
###############################################################################

resource "aws_iam_role" "cloudwatch_lambda_role" {
  #name = "${var.resource_prefix}-cloudwatch-lambda-${var.env}-role"
  name                = "${var.baseiamrole}004"
  assume_role_policy  = data.template_file.cloudwatch_lambda_role_template.rendered

  tags = merge(
      tomap(
        {
        "Name" = "${var.baseiamrole}003",
        "App" = "Iam role",
        "Scope" = "cloudwatch_lambda_role"
        }
        ),    
      "${var.default_tags}"
  )
}

resource "aws_iam_role_policy" "cloudwatch_lambda_policy" {
  name          = "${var.baseiampolicy}004"
  role          = aws_iam_role.cloudwatch_lambda_role.id
  policy        = data.template_file.cloudwatch_lambda_policy_template.rendered
}

###############################################################################
##### ROLE CLOUDRAIL LOG ######################################################
###############################################################################

resource "aws_iam_role" "cloudtrail_log_role" {
  #name               = "${var.resource_prefix}-cloudtrail-role-${var.env}"
  name                = "${var.baseiamrole}005"
  assume_role_policy  = data.template_file.cloudtrail_log_role_template.rendered
}

resource "aws_iam_role_policy" "cloudtrail_log_policy" {
  name          = "${var.baseiampolicy}005"
  role          = aws_iam_role.cloudtrail_log_role.id
  policy        = data.template_file.cloudtrail_log_policy_template.rendered
}
