resource "aws_security_group_rule" "rule" {
  description              = var.description
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id
  from_port                = var.from_port
  protocol                 = var.protocol
  to_port                  = var.to_port
  type                     = var.rule_type
}

