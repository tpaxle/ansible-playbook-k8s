locals {
  options = <<TOSTRINGA
----------------------------------------------------
---1.Init ------------------------------------------
----------------------------------------------------
S3 Buckets:
    - ${var.default_tags["_Application"]}-cloudfront-logs-${var.default_tags["_Environment"]}
    - ${var.default_tags["_Application"]}-elb-logs-${var.default_tags["_Environment"]}
    - ${var.default_tags["_Application"]}-r53-logs-${var.default_tags["_Environment"]}
    - ${var.default_tags["_Application"]}-s3-logs-${var.default_tags["_Environment"]}
    - ${var.default_tags["_Application"]}-vpcflow-logs-${var.default_tags["_Environment"]}
Roles:  
    - ${var.default_tags["_Application"]}-rds-monitoring-role-${var.default_tags["_Environment"]}
TOSTRINGA

}

output "toString" {
  value = local.options
}

