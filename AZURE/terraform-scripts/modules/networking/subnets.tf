
# Internal Clients (LTC)
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

# Ingress network
resource "azurerm_subnet" "sc-ingress" {
  name                 = "sc-ingress"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.sia-sc.name
  address_prefixes     = ["10.0.50.0/24"]
}
resource "azurerm_subnet_nat_gateway_association" "ingress-ngw-sn-assoc" {
  subnet_id      = azurerm_subnet.sc-ingress.id
  nat_gateway_id = azurerm_nat_gateway.nat-gw.id
}

# Admin (egress) network
resource "azurerm_subnet" "sc-admin" {
  name                 = "sc-admin"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.sia-sc.name
  address_prefixes     = ["10.0.60.0/24"]
}
resource "azurerm_subnet_nat_gateway_association" "admin-ngw-sn-assoc" {
  subnet_id      = azurerm_subnet.sc-admin.id
  nat_gateway_id = azurerm_nat_gateway.nat-gw.id
}
