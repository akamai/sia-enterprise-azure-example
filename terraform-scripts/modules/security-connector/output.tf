output "security_connector" {
    value = {
    instance = aws_instance.sc-connector,
    sg_ingress = aws_security_group.sc-ingress_if_sg,
    if_ingress = aws_network_interface.ingress,
    sg_admin = aws_security_group.sc-admin_if_sg,
    if_admin = aws_network_interface.admin,
    elastic_ip = aws_eip.admin_ip
  }
}