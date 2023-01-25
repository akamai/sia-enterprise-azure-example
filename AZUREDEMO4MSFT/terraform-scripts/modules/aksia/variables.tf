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

variable "sc-image-id" {
  description = "Akamai Security Connector Image ID in Azure"
  default = ""
}

variable "sc-subnet-id" {
  description = "The subnet to put the network interface into (default: None)"
}

variable "sc-key" {
  default = ""
  description = "SSH Key to allow Administrator to access Security Connector Console over SSH"
}