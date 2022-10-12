# Variables
## Additional variables
variable "nlb-name" {
  description = "Name for the Linux Test client"
  default = ""
}

## NLB details
variable "nlb-tags" {
  description = "Additional Linux Test Client Tags (default: None)"
}

variable "nlb-vpc_id" {
  description = "VPC ID to place the Instance and SG's into"
  default = ""
}

variable "nlb-instance_ids" {
  description = "Instance ID's of Security connectors to be added to the target groups"
  type = list(string)
  default = [""]
}

variable "nlb-subnet_ids" {
  description = "Subnet IDs to place the Network Load Balancer into"
  type = list(string)
  default = [""]
}

