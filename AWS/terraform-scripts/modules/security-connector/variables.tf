# Variables
## Additional variables
variable "sc-name" {
  description = "Name for the security connector"
  default = ""
}

## Instance details
variable "sc-instance-type" {
  description = "The Security connector instance type (default: t2.medium)"
  default = "t2.medium"
}

variable "sc-key_name" {
  description = "Name of the 'rsa public_key' to associate with the instance (default: None)"
}

variable "sc-ami-id" {
  description = "The Security Connector AMI ID (default: None)"
  default = ""
}

variable "sc-tags" {
  description = "Additional Security Connector Tags (default: None)"
}

## Network details
variable "sc-vpc_id" {
  description = "The VPC to place the SC in (default: None)"
}

variable "sc-ingress-subnet_id" {
  description = "The subnet to put the Ingress interface into (default: None)"
}

variable "sc-admin-subnet_id" {
  description = "The subnet to put the admin/egress interface into (default: None)"
}

