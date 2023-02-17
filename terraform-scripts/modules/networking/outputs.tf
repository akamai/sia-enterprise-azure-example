output "location" {
  value = azurerm_virtual_network.vnet-central.location
}

output "subnet-clients-id" {
    value = azurerm_subnet.subnet-clients.id
}

output "subnet-aksc-mgmt-id" {
    value = azurerm_subnet.subnet-aksc-mgmt.id
}

output "subnet-aksc-data-id" {
    value = azurerm_subnet.subnet-aksc-data.id
}


output "firewall_ip" {
    value = azurerm_public_ip.ip-azfirewall
}

