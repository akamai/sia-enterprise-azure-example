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

variable "sc-mgmt-ip" {
  default = ""
  type = string
  description = "Akamai Security Connector Management Private IP"
}

variable "sc-data-ip" {
  default = ""
  type = string
  description = "Akamai Security Connector Data IP"
}
variable "allow_list" {
  default = []
  type = list(string)
  description = "List of IP addresses allowed to access your lab"
}