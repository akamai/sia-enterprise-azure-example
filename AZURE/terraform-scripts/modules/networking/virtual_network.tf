resource "azurerm_virtual_network" "sia-sc" {
  name                = "vpc-sia-sc"
  resource_group_name = var.resource_group
  location            = var.region
  address_space       = ["10.0.0.0/16"]
}