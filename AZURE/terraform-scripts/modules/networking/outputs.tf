output "internal-clients" {
  value = azurerm_subnet.internal-clients
}
output "ingress-net" {
  value = azurerm_subnet.sc-ingress
}
output "admin-net" {
  value = azurerm_subnet.sc-admin
}