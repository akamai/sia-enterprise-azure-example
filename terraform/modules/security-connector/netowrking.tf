# Networking definitions
## Define the "ingress / internal" interface
resource "aws_network_interface" "ingress" {
  subnet_id   = var.sc-ingress-subnet_id
  tags = merge(
    {
    Name = "SC-Ingress Interface"
    }, var.sc-tags)
  security_groups = [aws_security_group.sc-ingress_if_sg.id]
}

## Define the "admin / egress" interface
resource "aws_network_interface" "admin" {
  subnet_id   = var.sc-ingress-subnet_id
  tags = merge(
    {
    Name = "SC-Admin Interface"
    }, var.sc-tags)
  security_groups = [aws_security_group.sc-admin_if_sg.id]
}

## Create an ELASTIC IP
resource "aws_eip" "admin_ip" {
  vpc      = true
}

## Assign the ELASTIC IP to the admin interface
resource "aws_eip_association" "eip_assoc" {
  network_interface_id = aws_network_interface.admin.id
  allocation_id = aws_eip.admin_ip.id
}