resource "aws_instance" "linux-test-client" {
  ami           = var.ltc-ami_id
  instance_type = var.ltc-instance-type
  key_name = var.ltc-key_name
  subnet_id = var.ltc-subnet_id
  vpc_security_group_ids = [aws_security_group.ltc-admin.id]
  associate_public_ip_address = true
  tags = merge(
    {
    Name = "${var.ltc-name}-ec2"
    }, var.ltc-tags)
}