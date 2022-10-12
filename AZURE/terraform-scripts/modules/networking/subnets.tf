resource "azurerm_subnet" "internal-clients" {
  name                 = "pub-internal-clients"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.sia-sc.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = azurerm_subnet.internal-clients.id
  nat_gateway_id = azurerm_nat_gateway.nat-gw.id
}