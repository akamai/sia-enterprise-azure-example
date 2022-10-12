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

variable "sc-name" {
  description = "Name for the security connector"
  default = ""
}

variable "sc-image-id" {
  description = "The Security Connector AMI ID (default: None)"
  default = ""
}

variable "sc-ingress-subnet_id" {
  description = "The subnet to put the Ingress interface into (default: None)"
}

variable "sc-admin-subnet_id" {
  description = "The subnet to put the admin/egress interface into (default: None)"
}

variable "sc-key" {
  default = ""
  description = "Yeah this is odd, we need the actual KEY"
}