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