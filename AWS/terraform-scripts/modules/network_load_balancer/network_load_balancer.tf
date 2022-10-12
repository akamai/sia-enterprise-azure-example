resource "aws_lb" "sc-nlb" {
  name               = "${var.nlb-name}-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = [for subnet in var.nlb-subnet_ids : subnet]
  enable_deletion_protection = false

  tags = merge(
  {
  Name = "${var.nlb-name}-nlb"
  }, var.nlb-tags)
}


resource "aws_lb_listener" "explicit" {
  load_balancer_arn = aws_lb.sc-nlb.arn
  port              = "8000"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.explicit_proxy.arn
  }
}

resource "aws_lb_listener" "implicit" {
  load_balancer_arn = aws_lb.sc-nlb.arn
  port              = "443"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.implicit_proxy.arn
  }
}