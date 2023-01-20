
output "w11-client-ip" {
    value = azurerm_network_interface.nic-client-windows11.ip_configuration[0].private_ip_address
}