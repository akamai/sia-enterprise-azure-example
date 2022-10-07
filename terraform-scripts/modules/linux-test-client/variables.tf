# Variables
## Additional variables
variable "ltc-name" {
  description = "Name for the Linux Test client"
  default = ""
}

## Instance details
variable "ltc-instance-type" {
  description = "The Linux Test Client instance type (default: t3.micro)"
  default = "t3.micro"
}

variable "ltc-ami_id" {
  description = "The Linux Test Client AMI ID (default: None)"
  default = ""
}

variable "ltc-tags" {
  description = "Additional Linux Test Client Tags (default: None)"
}


variable "ltc-key_name" {
  description = "Name of the 'rsa public_key' to associate with the instance (default: None)"
}

variable "ltc-subnet_id" {
  description = "Subnet ID to place Linux Test Client into (default: None)"
  default = ""
}

variable "tlc-vpc_id" {
  description = "VPC ID to place the Instance and SG's into"
  default = ""
}