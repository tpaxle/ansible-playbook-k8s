output "subdomain_zone_id" {
  value = aws_route53_zone.domain.zone_id
}

output "subdomain_name" {
  value = aws_route53_zone.domain.name
}

