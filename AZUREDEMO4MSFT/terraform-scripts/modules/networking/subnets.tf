
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
# 2 subnets:
# one for data traffic (DNS, SWG)
# one for Security Connector Device management (SSH/Web console access)
resource "azurerm_subnet" "subnet-aksc-mgmt" {
  name                 = "subnet-aksc-mgmt"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet-spoke-aksc.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_subnet" "subnet-aksc-data" {
  name                 = "subnet-aksc-data"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet-spoke-aksc.name
  address_prefixes     = ["10.2.2.0/24"]
}
