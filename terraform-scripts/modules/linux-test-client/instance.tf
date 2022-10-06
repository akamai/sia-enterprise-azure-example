resource "aws_instance" "linux-test-client" {
  ami           = var.ltc-ami_id
  instance_type = var.ltc-instance-type
  key_name = var.ltc-key_name
  subnet_id = var.ltc-subnet_id
  #security_groups = [aws_security_group.ltc-admin.id]
  associate_public_ip_address = true
}