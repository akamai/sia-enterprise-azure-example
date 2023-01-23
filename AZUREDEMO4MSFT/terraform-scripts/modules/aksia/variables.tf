variable "region" {
  default = ""
  type = string
  description = "Azure region"
}

variable "resource_group" {
  default = ""
  type = string
  description = "Azure Resource group id"
}

variable "sc-name" {
  description = "Name for the SIA Security Connector"
  default = ""
}

# az sig image-definition list-community --public-gallery-name AkamaiSC-25e2ec5b-5d88-4af3-8118-ade3f4ba7ea0 --location eastus
# Mike suggestion:
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/marketplace_agreement
variable "sc-image-id" {
  description = "Akamai Security Connector Image ID in Azure"
  # default = "/subscriptions/c3ab526d-d994-43c8-b0ab-c3eb185152d0/resourceGroups/sky-rg/providers/Microsoft.Compute/galleries/SkyImageGallery/images/sky-13965-20220919.44398044-debug-vhd/versions/0.0.1"
  # WRONG default = "/CommunityGalleries/AkamaiSC-25e2ec5b-5d88-4af3-8118-ade3f4ba7ea0/Images/sky-13965-20221110.45138874-deploy-vhd"
  # > No subscription ID found
  default = "AkamaiSC-25e2ec5b-5d88-4af3-8118-ade3f4ba7ea0"
}

variable "sc-subnet-data-id" {
  description = "The subnet to put the data interface into (default: None)"
}

variable "sc-subnet-mgmt-id" {
  description = "The subnet to put the admin/egress interface into (default: None)"
}

variable "sc-key" {
  default = ""
  description = "SSH Key to allow Administrator to access Security Connector Console over SSH"
}