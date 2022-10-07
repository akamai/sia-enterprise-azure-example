resource "aws_lb_target_group" "explicit_proxy" {
  name     = "${var.nlb-name}-nlb-tg-expl"
  port     = 8000
  protocol = "TCP"
  vpc_id   = var.nlb-vpc_id
  target_type = "instance"
  tags = merge(
  {
  Name = "${var.nlb-name}-nlb-tg-expl"
  }, var.nlb-tags)
  health_check {
    enabled = true
  }
}

resource "aws_lb_target_group_attachment" "explicit_proxy" {
  count = length(var.nlb-instance_ids)
  target_group_arn = aws_lb_target_group.explicit_proxy.arn
  target_id        = var.nlb-instance_ids[count.index]
  port             = 8000
}