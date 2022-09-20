
# Networking definitions
## Define the "ingress / internal" interface
resource "aws_network_interface" "ingress" {
  subnet_id   = var.sc-ingress-subnet_id
  tags = merge(
    {
    Name = "SC-Ingress Interface"
    }, var.sc-tags)
}

## Define the "admin / egress" interface
resource "aws_network_interface" "admin" {
  subnet_id   = var.sc-ingress-subnet_id
  tags = merge(
    {
    Name = "SC-Ingress Interface"
    }, var.sc-tags)
}

## Create an ELASTIC IP
resource "aws_eip" "public" {
  vpc      = true
}

resource "aws_instance" "sc-connector" {
  ami           = var.sc-ami-id
  instance_type = var.sc-instance-type

  network_interface {
    network_interface_id = aws_network_interface.ingress.id
    device_index         = 0
    delete_on_termination = true
  }

  network_interface {
    network_interface_id = aws_network_interface.admin.id
    device_index         = 1
    delete_on_termination = true
  }
}