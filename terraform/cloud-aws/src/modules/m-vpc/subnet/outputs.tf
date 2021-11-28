output "subnets_ids" {
  value = aws_subnet.sub.*.id
}

output "cidr_block" {
  value = aws_subnet.sub.*.cidr_block
}

