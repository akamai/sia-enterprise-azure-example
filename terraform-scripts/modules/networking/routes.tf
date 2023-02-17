# See also
# https://learn.microsoft.com/en-us/azure/firewall/tutorial-firewall-deploy-portal#create-a-default-route

resource "azurerm_route_table" "rt_azfirewall" {
  name                = "rt_azfirewall"
  location            = azurerm_virtual_network.vnet-central.location
  resource_group_name = var.resource_group
}

resource "azurerm_route" "rt-client-fw" {
  name                   = "rt-client-fw"
  resource_group_name    = var.resource_group
  route_table_name       = azurerm_route_table.rt_azfirewall.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.main-azfirewall.ip_configuration[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "route_assoc_client" {
  subnet_id      = azurerm_subnet.subnet-clients.id
  route_table_id = azurerm_route_table.rt_azfirewall.id
}

resource "azurerm_subnet_route_table_association" "route_assoc_aksc_data" {
  subnet_id      = azurerm_subnet.subnet-aksc-data.id
  route_table_id = azurerm_route_table.rt_azfirewall.id
}

resource "azurerm_subnet_route_table_association" "route_assoc_aksc_mgmt" {
  subnet_id      = azurerm_subnet.subnet-aksc-mgmt.id
  route_table_id = azurerm_route_table.rt_azfirewall.id
}
