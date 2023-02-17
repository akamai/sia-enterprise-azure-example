variable "region" {
  default = "eastus"
  type = string
  description = "Azure region"
}

variable "resource_group" {
  default = ""
  type = string
  description = "Azure Resource group id"
}

variable "location" {
  default = ""
  type = string
  description = "Azure Location"
}

variable "subnet_id" {
  default = ""
  type = string
  description = "Azure Subnet ID"
}

variable "w11_admin_password" {
  default = ""
  type = string
  description = "Windows Admin password for the Windows Client"
}