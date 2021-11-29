resource "aws_s3_bucket" "monitoring-storage" {
  count   = local.count_k8s_observability
  bucket  = "${var.default_tags["_Application"]}-monitoring-storage-${var.default_tags["_Environment"]}"
  acl     = "private"
  force_destroy = "true"

  tags = {
    Name = "${var.default_tags["_Application"]}-monitoring-storage-${var.default_tags["_Environment"]}"
    Team = var.default_tags["_Application"]
  }

  versioning {
    enabled = "false"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "monitoring-storage" {
  count = local.count_k8s_observability

  bucket = aws_s3_bucket.monitoring-storage[0].id

  policy = data.template_file.monitoring-storage-bucket-policy[0].rendered
}
