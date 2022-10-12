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
  ltc-name = "LTC-001"
  resource_group = var.resource_group
  region = var.region
  ltc-subnet_id = module.network.internal-clients.id
  ltc-key = var.ltc-key
}

module "sc001" {
  source = "./modules/security_connector/"
  sc-name = "SC-01"
  region = var.region
  resource_group = var.resource_group
  sc-key = var.ltc-key
  #sc-image-id = "sky-13965-20220921.44428485-debug-vhd"
  sc-image-id = "/subscriptions/c3ab526d-d994-43c8-b0ab-c3eb185152d0/resourceGroups/sky-rg/providers/Microsoft.Compute/galleries/SkyImageGallery/images/sky-13965-20220921.44428485-debug-vhd/versions/0.0.1"
  sc-ingress-subnet_id = module.network.ingress-net.id
  sc-admin-subnet_id = module.network.admin-net.id
}


##### OUTPUTS
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

output "sc001" {
  value = {
    "pub_admin_ip": module.sc001.sc.public_ip_address
  }
}
