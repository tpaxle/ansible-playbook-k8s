###########################
## Creating VPC ###########
###########################

resource "aws_lb" "lb" {
  name               = "${var.basenamenlb}${var.object_sequence}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.securitygroups
  subnets            = var.subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = var.bucketname
    prefix  = "${var.basenamenlb}${var.object_sequence}"
    enabled = true
  }

  tags = merge(
    {
      "Name" = "${var.basenamenlb}${var.object_sequence}"
    },
    var.default_tags,
  )
}

###Redirect 80 to https
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.certpolicy
  certificate_arn   = var.certificatearn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "target_https" {
  name        = "${var.basenamenlb}${var.object_sequence}-https"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpcid
}

resource "aws_lb_target_group" "target_http" {
  name        = "${var.basenamenlb}${var.object_sequence}-http"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpcid
}

#resource "aws_lb_target_group_attachment" "test" {
# target_group_arn = "${aws_lb_target_group.target.arn}"
#  target_id        = "10.0.0.1"
#  port             = 80
#  availability_zone = "all"
#}
