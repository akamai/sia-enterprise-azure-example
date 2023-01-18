# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall

resource "azurerm_public_ip" "ip-azfirewall" {
  name                = "ip-azfirewall"
  location            = azurerm_virtual_network.vnet-central.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "main-azfirewall" {
  name                = "main-azure-firewall"
  location            = azurerm_virtual_network.vnet-central.location
  resource_group_name = var.resource_group
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet-azfirewall.id
    public_ip_address_id = azurerm_public_ip.ip-azfirewall.id
  }
}
