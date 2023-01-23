# Template for the input variables of this project
# Please override these variable in your own .tfvars file

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

variable "w11_admin_password" {
  default = ""
  type = string
  description = "Windows Client admin password"
}

variable "allow_list" {
  default = []
  type = list(string)
  description = "List of IP addresses allowed to access your lab"
}

variable "sc-key" {
  description = "Akamai Security Connector 'rsa public_key' to associate with the instance (default: None)"
  default = ""
  type = string
}