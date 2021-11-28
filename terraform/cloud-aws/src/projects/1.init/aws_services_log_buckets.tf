###############################################################################
##### S3 BUCKET LOG CLOUDFRONT ################################################
###############################################################################
module "cloudfront_log_bucket" {
  source          = "../../modules/m-s3-new"
  acl             = "log-delivery-write"
  basenamebucket  = module.naming_convention.basenamebucket
  default_tags    = var.default_tags
  object_id       = "s3-cloudfront-log"
  object_sequence = local.cloudfront_log_bucket_object_sequence
  path            = "templates/cloudtrail_log_bucket_policy.tpl"
  region          = var.region
  tags            = {
    "Name" = "${module.naming_convention.basenamebucket}${local.cloudfront_log_bucket_object_sequence}"
    "App"  = "CloudFront"
  }
}

###############################################################################
##### S3 BUCKET LOG ELB #######################################################
###############################################################################
module "elb_log_bucket" {
  source          = "../../modules/m-s3-new"
  acl             = "log-delivery-write"
  basenamebucket  = module.naming_convention.basenamebucket
  default_tags    = var.default_tags
  object_id       = "s3-elb-log"
  object_sequence = local.elb_log_bucket_object_sequence
  path            = "templates/elb_log_bucket_policy.tpl"
  region          = var.region
  tags            = {
    "Name" = "${module.naming_convention.basenamebucket}${local.elb_log_bucket_object_sequence}"
    "App"  = "elb-logs"
  }
  template_vars = {
    elb_account_id = var.elb_log_accounts[var.region]
  }
}

###############################################################################
##### S3 BUCKET ROUTE 53 ######################################################
###############################################################################
module "r53_log_bucket" {
  source          = "../../modules/m-s3-new"
  basenamebucket  = module.naming_convention.basenamebucket
  default_tags    = var.default_tags
  object_id       = "s3-r53-log"
  object_sequence = local.r53_log_object_sequence
  path            = "templates/r53_log_bucket_policy.tpl"
  region          = var.region
  tags            = {
    "Name" = "${module.naming_convention.basenamebucket}${local.r53_log_object_sequence}"
    "App"  = "DNSR53"
  }
  template_vars = {
    account_id  = var.root_account
  }
}

###############################################################################
##### S3 BUCKET GENERAL LOGS ##################################################
###############################################################################

resource "aws_s3_bucket" "s3_log_bucket" {
  bucket        = "${module.naming_convention.basenamebucket}${local.s3_log_object_sequence}"
  acl           = "log-delivery-write"
  force_destroy = "true"

  lifecycle_rule {
    id      = "auto-delete-after-30-days"
    enabled = true

    expiration {
      days = 30
    }
  }

  tags = merge(
    {
      "Name" = "${module.naming_convention.basenamebucket}${local.s3_log_object_sequence}"
      "App"  = "LOGS"
    },
    var.default_tags,
  )
}

###############################################################################
##### S3 BUCKET flow LOGS #####################################################
###############################################################################
resource "aws_s3_bucket" "flow_log_bucket" {
  bucket        = "${module.naming_convention.basenamebucket}${local.flow_log_object_sequence}"
  acl           = "private"
  force_destroy = true

  tags = merge(
    {
      "Name" = "${module.naming_convention.basenamebucket}${local.flow_log_object_sequence}"
      "App"  = "FLOWLOGS"
    },
    var.default_tags,
  )

  versioning {
    enabled = "true"
  }

  lifecycle_rule {
    id      = "auto-delete-after-7-days"
    enabled = true

    expiration {
      days = 7
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "flow_log_bucket" {
  bucket = aws_s3_bucket.flow_log_bucket.id
  policy = data.template_file.flow_log_bucket_policy_template.rendered
}

###############################################################################
##### S3 BUCKET WAF LOGS ######################################################
###############################################################################
resource "aws_s3_bucket" "waf_log_bucket" {
  bucket        = "${module.naming_convention.basenamebucket}${local.waf_log_object_sequence}"
  acl           = "private"
  force_destroy = true

  tags = merge(
    {
      "Name" = "${module.naming_convention.basenamebucket}${local.waf_log_object_sequence}"
      "App"  = "WAFLOGS"
    },
    var.default_tags,
  )

  versioning {
    enabled = "true"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

###############################################################################
##### S3 BUCKET CLOUDWATCH LOGS ################################################
###############################################################################

resource "aws_s3_bucket" "cloudwatch_log_bucket" {
  bucket = "${module.naming_convention.basenamebucket}${local.cloudwatch_log_object_sequence}"
  acl    = "private"

  tags = merge(
    {
      "Name" = "${module.naming_convention.basenamebucket}${local.elb_log_bucket_object_sequence}"
      "App"  = "CLOUDWACH"
    },
    var.default_tags,
  )

  versioning {
    enabled = "false"
  }

  lifecycle_rule {
    id      = "delete-7d"
    enabled = true

    expiration {
      days = 7
    }
  }
  force_destroy = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

