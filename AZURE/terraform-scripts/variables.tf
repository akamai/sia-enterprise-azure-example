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


variable "ltc-key_name" {
  description = "Name of the 'rsa public_key' to associate with the instance (default: None)"
  default = ""
  type = string
}