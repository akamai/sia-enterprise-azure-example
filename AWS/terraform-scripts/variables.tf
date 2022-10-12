# Security Connector
variable "connector_vpc_id" {
  description = "VPC ID the connector lives in"
  type = string
  default = ""
}

variable "connector_internal_subnet" {
  description = "The Connector internal (en0) subnet"
  type = string
  default = ""
}

variable "connector_public_subnet" {
  description = "The Connector public (en1) subnet"
  type = string
  default = ""
}

variable "connector_ami_image_id" {
  description = "The AMI image ID of the connector image to use"
  type = string
  default = ""
}

# Linux Test Client
variable "ltc-instance-type" {
  description = "The Security connector instance type (default: t2.micro)"
  default = "t2.micro"
  type = string
}

variable "ltc-ami_id" {
  description = "The Security Connector AMI ID (default: None)"
  default = ""
  type = string
}

variable "ltc-tags" {
  description = "Additional Linux Test Client Tags (default: None)"
  default = ""
  type = string
}


variable "ltc-key_name" {
  description = "Name of the 'rsa public_key' to associate with the instance (default: None)"
  default = ""
  type = string
}

variable "ltc-subnet_id" {
  description = "Subnet ID to place Linux Test Client into (default: None)"
  default = ""
  type = string
}



variable "additional_tags" {
  description = "Additional Tags amended to all of the created resources"
  default = {}
}

variable "tlc-vpc_id" {
  description = "VPC ID to place the Instance and SG's into"
  default = ""
}

