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

module "security_connector01" {
  source = "./modules/security-connector/"
  sc-ingress-subnet_id = var.connector_internal_subnet
  sc-admin-subnet_id = var.connector_public_subnet
  sc-tags = var.additional_tags
  sc-vpc_id = var.connector_vpc_id
  sc-ami-id = var.connector_ami_image_id
}

module "linux_test_client01" {
  source = "./modules/linux-test-client/"
  ltc-subnet_id = var.ltc-subnet_id
  ltc-key_name = var.ltc-key_name
  ltc-tags = var.additional_tags
  ltc-ami_id = var.ltc-ami_id
  tlc-vpc_id = var.tlc-vpc_id
}

output "sc01" {
  value = {
    instance_id = module.security_connector01.security_connector.instance.id,
    admin_ip = module.security_connector01.security_connector.elastic_ip.public_ip,
    ingress_ip = module.security_connector01.security_connector.if_ingress.private_ip
  }
}

output "ltc01" {
  value = {
    instance_id = module.linux_test_client01.linux_text_client.instance.id,
    public_ip = module.linux_test_client01.linux_text_client.instance.public_ip
  }
}