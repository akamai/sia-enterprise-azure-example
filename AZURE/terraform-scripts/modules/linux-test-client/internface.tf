resource "azurerm_network_interface" "ltc-if0" {
  name                = "example-nic"
  location            = var.region
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.ltc-subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.ltc-pubip.id
  }
}

resource "azurerm_public_ip" "ltc-pubip" {
  name                = "ltc-publicIP"
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}