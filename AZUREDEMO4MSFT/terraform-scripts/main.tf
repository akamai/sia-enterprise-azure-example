terraform {
  # Which version is minimum required version for TF
  required_version = ">=0.14.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version  = "~> 3.37.0"
    }
  }

    backend "local" {
      path = "../tf-state/azure_terraform.tfstate"
    }
}
    provider "azurerm" {
      features {}
    }

#-------------------

# Virtual Networks, Subnet, Route, Azure Firewall
module "network" {
  source = "./modules/networking/"
  resource_group = var.resource_group
  region = var.region
  w11_client_ip = module.client.w11-client-ip
  sc-ip = module.aksia.sc-ip
  allow_list = var.allow_list
}

# Windows Client
module "client" {
  source = "./modules/client/"
  resource_group = var.resource_group
  region = var.region
  subnet_id = module.network.subnet-clients-id
  location = module.network.location
  w11_admin_password = var.w11_admin_password
}

# Akamai Secure Internet Access Security Connector virtual appliance(s)
module "aksia" {
  source = "./modules/aksia/"
  sc-name = "Ak-SIA-SC"
  region = var.region
  resource_group = var.resource_group
  sc-key = var.sc-key
  sc-subnet-id = module.network.subnet-aksc-id
}

##### OUTPUTS
/* 

output "networks" {
  value = {
    "internal-clients": module.network.internal-clients
  }
}

output "sc001" {
  value = {
    "pub_admin_ip": module.sc001.sc.public_ip_address
  }
}
 */