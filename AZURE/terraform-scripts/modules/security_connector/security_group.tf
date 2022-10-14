resource "azurerm_network_security_group" "sc-sg-ingress" {
  name                = "${var.sc-name}-sg-ingress"
  location            = var.region
  resource_group_name = var.resource_group

  security_rule {
    name                       = "explicit"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "imlpicit"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "dns-tcp"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "dns-udp"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "ssh"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "sg-association-ingress" {
  subnet_id                 = var.sc-ingress-subnet_id
  network_security_group_id = azurerm_network_security_group.sc-sg-ingress.id
}


### Admin internface
resource "azurerm_network_security_group" "sc-sg-admin" {
  name                = "${var.sc-name}-sg-admin"
  location            = var.region
  resource_group_name = var.resource_group

  security_rule {
    name                       = "ssh"
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

resource "azurerm_subnet_network_security_group_association" "sg-association-admin" {
  subnet_id                 = var.sc-admin-subnet_id
  network_security_group_id = azurerm_network_security_group.sc-sg-admin.id
}