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

variable "w11_client_ip" {
  default = ""
  type = string
  description = "Windows 11 Client IP"
}