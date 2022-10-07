output "nlb" {
    value = {
        nlb = aws_lb.sc-nlb,
        tg_explicit = aws_lb_target_group.explicit_proxy
  }
}