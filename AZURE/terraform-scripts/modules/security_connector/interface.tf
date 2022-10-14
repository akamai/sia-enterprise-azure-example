resource "azurerm_network_interface" "sc-if0" {
  name                = "${var.sc-name}-if0"
  location            = var.region
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.sc-ingress-subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.sc-pubip2.id
  }
}

resource "azurerm_public_ip" "sc-pubip2" {
  name                = "${var.sc-name}-publicIP2"
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}



resource "azurerm_network_interface" "sc-if1" {
  name                = "${var.sc-name}-if1"
  location            = var.region
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "admin"
    subnet_id                     = var.sc-admin-subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.sc-pubip.id
  }
}

resource "azurerm_public_ip" "sc-pubip" {
  name                = "${var.sc-name}-publicIP"
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}