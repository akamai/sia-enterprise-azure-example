resource "azurerm_public_ip" "natgw-ip" {
  name                = "nat-gw-publicIP"
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "nat-gw" {
  name                    = "nat-Gateway"
  location                = var.region
  resource_group_name     = var.resource_group
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "natgw-pubIp-assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat-gw.id
  public_ip_address_id = azurerm_public_ip.natgw-ip.id
}