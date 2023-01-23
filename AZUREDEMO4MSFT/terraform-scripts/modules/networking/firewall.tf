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

# Rule Policy and Collections
  /*
resource "azurerm_firewall_policy" "fw-policy" {
  name                = "fw-policy"
  resource_group_name = var.resource_group
  location            = azurerm_virtual_network.vnet-central.location
}

resource "azurerm_firewall_policy_rule_collection_group" "fw-rule-collection" {
  name               = "fw-rule-collection"
  firewall_policy_id = azurerm_firewall_policy.fw-policy.id
  priority           = 500


  application_rule_collection {
    name     = "allow-browsing-web"
    priority = 500
    action   = "Allow"
    rule {
      name = "app_rule_collection1_rule1"
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


  network_rule_collection {
    name     = "network_rule_client"
    priority = 400
    action   = "Allow"

    rule {
      name                  = "nr_allow_web_traffic"
      protocols             = ["TCP"]
      source_addresses      = ["10.3.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["80", "443"]
    }

    rule {
      name                  = "nr_allow_external_dns"
      protocols             = ["UDP", "TCP"]
      source_addresses      = ["10.3.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }

  }

  # Version with Firewall Manager
  nat_rule_collection {
    name     = "nat_rdp"
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
  }

   
} */

# Network Rules (Classic)
resource "azurerm_firewall_network_rule_collection" "nr_web_from_client" {
  name                = "fw_nr_collection"
  azure_firewall_name = azurerm_firewall.main-azfirewall.name
  resource_group_name = var.resource_group
  priority            = 200
  action              = "Allow"

  rule {
    name = "allow-web-browsing"

    source_addresses = [
      "10.3.0.0/16", # TODO: pick the vnet-clients ipcidr
    ]

    destination_ports = [
      "80", "443"
    ]

    destination_addresses = [
      "*",
    ]

    protocols = [
      "TCP",
    ]
  }

  rule {
    name = "allow-aksec-outbound"

    source_addresses = [
      "10.2.0.0/16", # TODO: pick the vnet-aksc cidr
    ]

    destination_ports = [ "*", ]

    destination_addresses = [
      "*",
    ]

    protocols = [
      "TCP", "UDP"
    ]
  }


}

# NAT rules (Classic)

resource "azurerm_firewall_nat_rule_collection" "nat_rdp" {
  name                = "fw_nat_collection"
  azure_firewall_name = azurerm_firewall.main-azfirewall.name
  resource_group_name = var.resource_group
  priority            = 100
  action              = "Dnat"

  rule {
    name = "w11-rdp"

    source_addresses = var.allow_list

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

  rule {
    name = "sc-ssh"

    source_addresses = var.allow_list

    destination_ports = [
      "30002",
    ]

    destination_addresses = [
      azurerm_public_ip.ip-azfirewall.ip_address,
    ]

    translated_port = 22

    translated_address = var.sc-mgmt-ip

    protocols = [
      "TCP",
    ]
  } 

rule {
    name = "sc-ssh-bis"

    source_addresses = var.allow_list

    destination_ports = [
      "30003",
    ]

    destination_addresses = [
      azurerm_public_ip.ip-azfirewall.ip_address,
    ]

    translated_port = 22

    translated_address = var.sc-

    protocols = [
      "TCP",
    ]
  } 

}

