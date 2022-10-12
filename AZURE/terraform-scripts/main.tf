terraform {
  # Which version is minimum required version for TF
  required_version = ">=0.14.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version  = "~> 3.0.0"
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

module "network" {
  source = "./modules/networking/"
  resource_group = var.resource_group
  region = var.region
}

module "ltc01" {
  source = "./modules/linux-test-client/"
  resource_group = var.resource_group
  region = var.region
  ltc-subnet_id = module.network.internal-clients.id
  ltc-key_name = var.ltc-key_name
}

output "networks" {
  value = {
    "internal-clients": module.network.internal-clients
  }
}

output "ltc-001" {
  value = {
    "public_ip" : module.ltc01.ltc.public_ip_address,
    "private_ip": module.ltc01.ltc.private_ip_address
  }
  #sensitive = false
}