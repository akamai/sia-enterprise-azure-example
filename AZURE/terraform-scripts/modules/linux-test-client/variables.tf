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

#### LTC
variable "ltc-name" {
  default = "ltc"
  type = string
  description = "Specific Name for this Linux test client"
}

variable "ltc-subnet_id" {
  default = ""
  description = "Subnet to place the Linux Test Client"
}

variable "ltc-key" {
  default = ""
  description = "Yeah this is odd, we need the actual KEY"
}