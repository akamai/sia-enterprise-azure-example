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

variable "additional_tags" {
  default = {}
}