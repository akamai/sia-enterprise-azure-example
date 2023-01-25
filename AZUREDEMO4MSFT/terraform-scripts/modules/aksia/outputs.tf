output "sc-ip" {
    value = azurerm_network_interface.sc-netif.ip_configuration[0].private_ip_address
}