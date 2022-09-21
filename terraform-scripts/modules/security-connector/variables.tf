# Variables

variable "sc-instance-type" {
  default = "t2.medium"
}

variable "sc-ami-id" {
  default = "ami-09bfb182e705989e1"
}

variable "sc-tags" {}

# Network details
variable "sc-vpc_id" {}
variable "sc-ingress-subnet_id" {}
variable "sc-admin-subnet_id" {}