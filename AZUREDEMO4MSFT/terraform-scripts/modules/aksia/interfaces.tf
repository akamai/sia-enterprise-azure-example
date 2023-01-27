# Management interface
# The IP address will be added as a DNAT rule into Azure Firewall
resource "azurerm_network_interface" "sc-netif-mgmt" {
  name                = "${var.sc-name}-netif-mgmt"
  location            = var.region
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "sc-ip-mgmt"
    subnet_id                     = var.sc-subnet-mgmt-id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "sc-netif-data" {
  name                = "${var.sc-name}-netif-data"
  location            = var.region
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "sc-ip-data"
    subnet_id                     = var.sc-subnet-data-id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.2.2.100"
  }
}