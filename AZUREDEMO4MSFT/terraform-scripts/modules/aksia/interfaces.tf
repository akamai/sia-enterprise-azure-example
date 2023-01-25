# Management interface
# The IP address will be added as a DNAT rule into Azure Firewall
resource "azurerm_network_interface" "sc-netif" {
  name                = "${var.sc-name}-netif"
  location            = var.region
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "sc-ip"
    subnet_id                     = var.sc-subnet-id
    private_ip_address_allocation = "Dynamic"
  }
}
