resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.new_name
  type    = "CNAME"
  ttl     = "60"
  records = [var.records]
}

