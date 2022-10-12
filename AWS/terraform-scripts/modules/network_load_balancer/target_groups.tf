
# Explicit
resource "aws_lb_target_group" "explicit_proxy" {
  name     = "${var.nlb-name}-nlb-tg-expl"
  port     = 8000
  protocol = "TCP"
  vpc_id   = var.nlb-vpc_id
  target_type = "instance"
  health_check {
    protocol = "TCP"
    matcher = ""
    path = ""
    port = 8000
  }
  tags = merge(
  {
  Name = "${var.nlb-name}-nlb-tg-expl"
  }, var.nlb-tags)
}

resource "aws_lb_target_group_attachment" "explicit_proxy" {
  count = length(var.nlb-instance_ids)
  target_group_arn = aws_lb_target_group.explicit_proxy.arn
  target_id        = var.nlb-instance_ids[count.index]
  port             = 8000
}

### Implicit
resource "aws_lb_target_group" "implicit_proxy" {
  name     = "${var.nlb-name}-nlb-tg-impl"
  port     = 443
  protocol = "TCP"
  vpc_id   = var.nlb-vpc_id
  target_type = "instance"
    health_check {
    protocol = "TCP"
    matcher = ""
    path = ""
    port = 443
  }
  tags = merge(
  {
  Name = "${var.nlb-name}-nlb-tg-impl"
  }, var.nlb-tags)
}

resource "aws_lb_target_group_attachment" "implicit_proxy" {
  count = length(var.nlb-instance_ids)
  target_group_arn = aws_lb_target_group.implicit_proxy.arn
  target_id        = var.nlb-instance_ids[count.index]
  port             = 443
}