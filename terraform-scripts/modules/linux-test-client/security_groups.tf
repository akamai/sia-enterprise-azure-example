# Define Security group(s)

## Admin Interface Security Group
resource "aws_security_group" "ltc-admin" {
  name        = "ltc-admin_if_sg"
  description = "Allow connections to the linux test client"
  vpc_id      = var.tlc-vpc_id

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ltc-admin_if_sg"
  }
}