output "sc-mgmt-ip" {
    value = azurerm_network_interface.sc-netif-mgmt.ip_configuration[0].private_ip_address
}

output "sc-data-ip" {
    value = azurerm_network_interface.sc-netif-data.ip_configuration[0].private_ip_address
}