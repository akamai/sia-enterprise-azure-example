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

variable "ltc-subnet_id" {
  default = ""
  description = "Subnet to place the Linux Test Client"
}

variable "ltc-key_name" {
  default = ""
  description = ""
}