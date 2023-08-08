locals {
  name = "${var.name}-${var.environment}"
}

resource "aws_lb" "default" {
  name               = local.name
  internal           = var.public == null
  load_balancer_type = "application"
  subnets = flatten([
    var.private != null ? var.private.subnets : [],
    var.public != null ? var.public.subnets : [],
  ])
  security_groups = [aws_security_group.default.arn]

  enable_deletion_protection = false
  tags                       = var.tags
}

resource "aws_security_group" "default" {
  name        = "${local.name}-sg"
  description = "${local.name} ALB Security Group"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

resource "aws_lb_listener" "private" {
  count             = var.private != null ? 1 : 0
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "private ${local.name} ALB"
      status_code  = "200"
    }
  }

  tags = var.tags
}

resource "aws_lb_listener" "public" {
  count             = var.public != null ? 1 : 0
  load_balancer_arn = aws_lb.default.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.public.ssl.ssl_policy
  certificate_arn   = var.public.ssl.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "private ${local.name} ALB"
      status_code  = "200"
    }
  }

  tags = var.tags
}

resource "aws_security_group_rule" "public_https" {
  count             = var.public != null ? 1 : 0
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  security_group_id = aws_security_group.default.arn
  description       = "${local.name} HTTPS Public Access"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
