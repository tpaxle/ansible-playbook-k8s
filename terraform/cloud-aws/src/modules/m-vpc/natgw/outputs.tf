output "vpc_ngw_id" {
  value = aws_nat_gateway.ngw.*.id
}

output "vpc_ngw_ip" {
  value = aws_nat_gateway.ngw.*.public_ip
}
