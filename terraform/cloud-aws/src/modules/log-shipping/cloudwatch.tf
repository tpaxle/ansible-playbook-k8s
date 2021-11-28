
### Log group in CloudWatch to send initial logs to (may be created by cloudwatch agents or lambda etc)
data "aws_cloudwatch_log_group" "existing_log_groups" {
  count = length(var.cloudwatch_log_groups)
  name  = lookup(var.cloudwatch_log_groups[count.index], "name")
}

### Subscription Filter sends new filtered events from the Log Group to the Log Destination
resource "aws_cloudwatch_log_subscription_filter" "cloudwatch_log_filter" {
  count           = length(var.cloudwatch_log_groups)
  name            = "${var.basenamecwf}${lookup(var.cloudwatch_log_groups[count.index], "keyword")}"
  log_group_name  = lookup(var.cloudwatch_log_groups[count.index], "name")
  destination_arn = aws_cloudwatch_log_destination.cloudwatch_log_destination.arn
  filter_pattern  = ""
  distribution    = "ByLogStream"

  depends_on = [data.aws_cloudwatch_log_group.existing_log_groups]
}

### CloudWatch log destination which receives logs from the Subscription Filter and forwards them to the Delivery Stream
resource "aws_cloudwatch_log_destination" "cloudwatch_log_destination" {
  name       = "${var.basenamecld}001"
  target_arn = aws_kinesis_firehose_delivery_stream.cloudwatch_log_delivery_stream.arn
  role_arn   = aws_iam_role.cloudwatch_to_firehose_role.arn
}




### Firehose Delivery Stream sending data to S3
resource "aws_kinesis_firehose_delivery_stream" "cloudwatch_log_delivery_stream" {
  name       = "${var.basenamekfd}001"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn        = aws_iam_role.firehose_for_cloudwatch_logs.arn
    bucket_arn      = var.s3_logs_arn
    buffer_interval = 60
    buffer_size     = 1

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.cloudwatch_lambda.arn}:$LATEST"
        }

        parameters {
          parameter_name  = "BufferSizeInMBs"
          parameter_value = "1"
        }

        parameters {
          parameter_name  = "BufferIntervalInSeconds"
          parameter_value = "60"
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      extended_s3_configuration[0].processing_configuration[0].processors[0],
    ]
  }
}

### Lambda to unzip the cloudwatch logs before passing them to firehose

resource "aws_lambda_function" "cloudwatch_lambda" {
  filename         = "cloudwatch_log_processor.zip"
  source_code_hash = data.archive_file.cloudwatch_log_processor_zip.output_base64sha256
  function_name    = "${var.basenamelambdafunction}001"
  role             = aws_iam_role.cloudwatch_lambda_role.arn
  handler          = "cloudwatch_log_processor.lambda_handler"
  runtime          = "python3.9"
  timeout          = 60
}

resource "aws_lambda_permission" "allow_call_from_firehose" {
  statement_id  = "AllowExecutionFromFirehose"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudwatch_lambda.arn
  principal     = "firehose.amazonaws.com"
  source_arn    = aws_kinesis_firehose_delivery_stream.cloudwatch_log_delivery_stream.arn
}
