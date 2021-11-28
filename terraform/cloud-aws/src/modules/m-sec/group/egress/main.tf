resource "aws_security_group" "sg" {
  name   = "${var.basenamesgr}${var.object_sequence}"
  vpc_id = var.vpc_id

  egress {
    from_port = var.from_port
    to_port   = var.to_port
    protocol  = var.protocol

    cidr_blocks = var.es_access_cidr
  }

  tags = merge(
    {
      "Name" = "${var.basenamesgr}${var.object_sequence}"
    },
    var.default_tags,
  )
}

