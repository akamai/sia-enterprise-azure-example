resource "azurerm_network_security_group" "ltc-sg" {
  name                = "${var.ltc-name}-sg"
  location            = var.region
  resource_group_name = var.resource_group

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "sg-association" {
  subnet_id                 = var.ltc-subnet_id
  network_security_group_id = azurerm_network_security_group.ltc-sg.id
}