output "location" {
  value = azurerm_virtual_network.vnet-central.location
}

output "subnet-clients-id" {
    value = azurerm_subnet.subnet-clients.id
}