
# Test Clients
resource "azurerm_subnet" "subnet-clients" {
  name                 = "subnet-clients"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet-spoke-client.name
  address_prefixes     = ["10.3.1.0/24"]
}

# Azure Firewall
resource "azurerm_subnet" "subnet-azfirewall" {
  name                 = "AzureFirewallSubnet" # was "subnet-azfirewall" but Azure requires it to be AzureFirewallSubnet
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet-central.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Akamai ETP/SIA Security Connector
resource "azurerm_subnet" "subnet-aksc" {
  name                 = "subnet-aksc"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet-spoke-aksc.name
  address_prefixes     = ["10.2.1.0/24"]
}
