# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall

resource "azurerm_public_ip" "ip-azfirewall" {
  name                = "ip-azfirewall"
  location            = azurerm_virtual_network.vnet-central.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "main-azfirewall" {
  name                = "main-azfirewall"
  location            = azurerm_virtual_network.vnet-central.location
  resource_group_name = var.resource_group
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet-azfirewall.id
    public_ip_address_id = azurerm_public_ip.ip-azfirewall.id
  }
}
resource "azurerm_firewall_nat_rule_collection" "nat_rdp" {
  name                = "fw_collection"
  azure_firewall_name = azurerm_firewall.main-azfirewall.name
  resource_group_name = var.resource_group
  priority            = 100
  action              = "Dnat"

  rule {
    name = "w11-rdp"

    source_addresses = [
      "174.127.243.153/32", # Antoine Work From Home
    ]

    destination_ports = [
      "30001",
    ]

    destination_addresses = [
      azurerm_public_ip.ip-azfirewall.ip_address,
    ]

    translated_port = 3389

    translated_address = var.w11_client_ip

    protocols = [
      "TCP",
    ]
  }
}