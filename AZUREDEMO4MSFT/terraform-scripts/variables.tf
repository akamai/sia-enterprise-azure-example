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


