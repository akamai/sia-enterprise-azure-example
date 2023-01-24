# See diagram in:
# https://collaborate.akamai.com/confluence/display/ETME/ETP+Protection+in+Azure

resource "azurerm_virtual_network" "vnet-central" {
  name                = "vnet-central"
  resource_group_name = var.resource_group
  location            = var.region
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "vnet-spoke-aksc" {
  name                = "vnet-spoke-aksc"
  resource_group_name = var.resource_group
  location            = var.region
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_virtual_network" "vnet-spoke-client" {
  name                = "vnet-spoke-client"
  resource_group_name = var.resource_group
  location            = var.region
  address_space       = ["10.3.0.0/16"]
}

# Peerings between Virtual Networks

## Central ⇄ Security Connector

resource "azurerm_virtual_network_peering" "peering-central-to-aksc" {
  name                      = "peering-central-to-aksc"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet-central.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-spoke-aksc.id
}

resource "azurerm_virtual_network_peering" "peering-aksc-to-central" {
  name                      = "peering-aksc-to-central"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet-spoke-aksc.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-central.id
}

## Central ⇄ Client

resource "azurerm_virtual_network_peering" "peering-central-to-client" {
  name                      = "peering-central-to-client"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet-central.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-spoke-client.id
}

resource "azurerm_virtual_network_peering" "peering-client-to-central" {
  name                      = "peering-client-to-central"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet-spoke-client.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-central.id
}

## SC ⇄ Client

resource "azurerm_virtual_network_peering" "peering-aksc-to-client" {
  name                      = "peering-aksc-to-client"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet-spoke-aksc.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-spoke-client.id
}

resource "azurerm_virtual_network_peering" "peering-client-to-aksc" {
  name                      = "peering-client-to-aksc"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet-spoke-client.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-spoke-aksc.id
}