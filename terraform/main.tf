terraform {
  # Which version is minimum required version for TF
  required_version = ">=0.14.1"

  # Define required providers
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.10"
    }
  }

  backend "local" {
    path = "../tf-state/terraform.tfstate"
  }

#  backend "http" {
#    address = "https://gitlab.com/api/v4/projects/35550476/terraform/state/ph-tf-aws-001-state"
#    lock_address = "https://gitlab.com/api/v4/projects/35550476/terraform/state/ph-tf-aws-001-state/lock"
#    lock_method = "POST"
#    unlock_address = "https://gitlab.com/api/v4/projects/35550476/terraform/state/ph-tf-aws-001-state/lock"
#    unlock_method = "DELETE"
#    retry_wait_min = 5
#  }

}

provider "aws" {
  region = "eu-central-1"
  shared_credentials_files = ["../.aws_creds"]
}

module "test" {
  source = "./modules/security-connector/"
  sc-ingress-subnet_id = "subnet-0511677247db6fda7"
  sc-admin-subnet_id = "subnet-0aae78f20996f0ff0"
  sc-tags = {}
  sc-vpc_id = "vpc-06f71c72d76104523"
}