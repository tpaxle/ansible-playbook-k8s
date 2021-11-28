###############################################################################
##### DNS ZONE ################################################################
###############################################################################

# Create the subdomain in the current account
resource "aws_route53_zone" "domain" {
  name          = "${local.domain_name}."
  force_destroy = "true"
  vpc {
    vpc_id = var.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
  tags = merge(
    {
      "Name"  = "${var.basenamedns}${var.object_sequence}"
      "Name1" = "${local.domain_name}."
      "DNS"   = var.tag_infra_unit
    },
    var.default_tags,
  )
}
