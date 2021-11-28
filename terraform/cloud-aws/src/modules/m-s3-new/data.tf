
data "template_file" "policy_template" {
  template = file(var.path)

  vars = merge(
    {
      bucket_name    = aws_s3_bucket.bucket.id
    },
    var.template_vars
  )
}