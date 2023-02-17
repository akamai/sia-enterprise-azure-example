# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall

# Azure firewall basic

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

  # Azure Firewall will rely on Akamai SIA Security Connector to perform DNS lookups
  dns_servers = [var.sc-data-ip, ]
}

# Classic

## Classic > Network Rules

resource "azurerm_firewall_network_rule_collection" "nr_web_from_client" {
  count               = var.azure_firewall_rule_mode == "classic" ? 1 : 0
  name                = "fw_nr_collection"
  azure_firewall_name = azurerm_firewall.main-azfirewall.name
  resource_group_name = var.resource_group
  priority            = 200
  action              = "Allow"

  rule {
    name = "allow-web-browsing"
    source_addresses = azurerm_virtual_network.vnet-spoke-client.address_space
    destination_ports = ["80", "443"]
    destination_addresses = ["*",]
    protocols = ["TCP",]
  }

  # Uncomment only if you want to test 3rd party DNS provider publicly available
  /*
  rule {
    name = "allow-external-dns-troubleshooting"
    source_addresses = azurerm_virtual_network.vnet-spoke-client.address_space
    destination_ports = ["53"]
    destination_addresses = ["*",]
    protocols = ["TCP", "UDP"]
  }
  */

  rule {
    # Strictly speaking only TCP/443 and UDP/123 should be required
    name = "allow-aksec-outbound"

    source_addresses = azurerm_virtual_network.vnet-spoke-aksc.address_space

    destination_ports = [ "*", ]

    destination_addresses = [
      "*",
    ]

    protocols = [
      "TCP", "UDP", "ICMP"
    ]
  }
}

## Classic > NAT rules
resource "azurerm_firewall_nat_rule_collection" "nat_rules" {
  count               = var.azure_firewall_rule_mode == "classic" ? 1 : 0
  name                = "fw_nat_collection"
  azure_firewall_name = azurerm_firewall.main-azfirewall.name
  resource_group_name = var.resource_group
  priority            = 100
  action              = "Dnat"

  rule {
    name = "rdp-remote-access"
    source_addresses = var.allow_list
    destination_ports = ["30001",]
    destination_addresses = [
      azurerm_public_ip.ip-azfirewall.ip_address,
    ]
    translated_port = 3389
    translated_address = var.w11_client_ip
    protocols = ["TCP",]
  }

  rule {
    name = "sc-ssh"
    source_addresses = var.allow_list
    destination_ports = ["30002",]
    destination_addresses = [
      azurerm_public_ip.ip-azfirewall.ip_address,
    ]
    translated_port = 22
    translated_address = var.sc-mgmt-ip
    protocols = ["TCP",]
  }

}

# Policy

resource "azurerm_firewall_policy" "fw-policy" {
  count               = var.azure_firewall_rule_mode == "policy" ? 1 : 0
  name                = "fw-policy"
  resource_group_name = var.resource_group
  location            = azurerm_virtual_network.vnet-central.location

  # Will proxy incoming DNS requests to the Akamai SIA Security Connector
  dns {
    proxy_enabled = true
    servers = [var.sc-data-ip,]
  }
}

## Policy > Rule Collection

resource "azurerm_firewall_policy_rule_collection_group" "fw-rule-collection" {
  count               = var.azure_firewall_rule_mode == "policy" ? 1 : 0
  name               = "fw-rule-collection"
  firewall_policy_id = azurerm_firewall_policy.fw-policy[0].id
  priority           = 500

  application_rule_collection {
    name     = "web-browsing"
    priority = 500
    action   = "Allow"
    rule {
      name = "app_rule_web_browsing_rule"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["10.3.0.0/16"] # TODO: replace with the CIDR property from subnet-clients
      destination_fqdns = ["*"]
    }
  }

  nat_rule_collection {
    name     = "nat_port_forward"
    priority = 300
    action   = "Dnat"
    rule {
      name                = "nat_rule_rdp_w11"
      protocols           = ["TCP"]
      source_addresses    = var.allow_list
      destination_address = azurerm_public_ip.ip-azfirewall.ip_address
      destination_ports   = ["30001"]
      translated_address  = var.w11_client_ip
      translated_port     = "3389"
    }

    rule {
      name                = "nat_rule_sc_ssh"
      protocols           = ["TCP"]
      source_addresses    = var.allow_list
      destination_address = azurerm_public_ip.ip-azfirewall.ip_address
      destination_ports   = ["30002"]
      translated_address  = var.sc-mgmt-ip
      translated_port     = "22"
    }
  }
   
} 
