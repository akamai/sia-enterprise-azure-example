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