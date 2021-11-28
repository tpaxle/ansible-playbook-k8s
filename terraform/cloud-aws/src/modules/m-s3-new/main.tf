###########################
## Creating VPC ###########
###########################

##### ELB #####
resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.basenamebucket}${var.object_sequence}"
  acl           = var.acl
  force_destroy = "true"

  lifecycle_rule {
    id      = "auto-delete-after-30-days"
    enabled = true

    expiration {
      days = 30
    }
  }

  tags = merge(
    var.tags,
    var.default_tags,
  )
}

resource "aws_s3_bucket_policy" "policy_assing" {
  bucket = aws_s3_bucket.bucket.id

  policy = data.template_file.policy_template.rendered
}

