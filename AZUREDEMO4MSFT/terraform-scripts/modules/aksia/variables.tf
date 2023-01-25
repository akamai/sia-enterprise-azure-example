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