# Instance definition
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "sc-connector" {
  ami           = var.sc-ami-id
  instance_type = var.sc-instance-type
  tags = merge(
    {
    Name = "${var.sc-name}-ec2"
    }, var.sc-tags)

  network_interface {
    network_interface_id = aws_network_interface.ingress.id
    device_index         = 0
    delete_on_termination = false
  }

  network_interface {
    network_interface_id = aws_network_interface.admin.id
    device_index         = 1
    delete_on_termination = false
  }

}