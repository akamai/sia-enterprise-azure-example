# Define Security group(s)

## Ingress Interface Security Group
resource "aws_security_group" "sc-ingress_if_sg" {
  name        = "${var.sc-name}-sc-ingress_if_sg"
  description = "Allow connections ingress interface"
  vpc_id      = var.sc-vpc_id

  ingress {
    description      = "HTTPS from everywhere (implicit Proxy)"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "DNS (UDP) from everywhere"
    from_port        = 53
    to_port          = 53
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTPS from everywhere (explicit Proxy)"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "DNS (TCP) from everywhere"
    from_port        = 53
    to_port          = 53
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

  tags = merge(
    {
    Name = "${var.sc-name}-sc-ingress_if_sg"
    }, var.sc-tags)

}

## Admin Interface Security Group
resource "aws_security_group" "sc-admin_if_sg" {
  name        = "${var.sc-name}-sc-admin_if_sg"
  description = "Allow connections admin interface"
  vpc_id      = var.sc-vpc_id

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

  tags = merge(
    {
    Name = "${var.sc-name}-sc-admin_if_sg"
    }, var.sc-tags)
}