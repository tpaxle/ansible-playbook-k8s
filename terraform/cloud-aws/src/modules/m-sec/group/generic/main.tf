resource "aws_security_group" "sg" {
  name   = "${var.default_tags["_Application"]}-${var.object_sufix}-access-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = var.from_port
    to_port   = var.to_port
    protocol  = var.protocol

    cidr_blocks = var.es_access_cidr
  }

  tags = {
    Name = "${var.default_tags["_Application"]}-${var.object_sufix}-access-sg"
  }
}

