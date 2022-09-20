# etp-connector-tf

This repo is meant to support ETP ENG team in order to automate cloud installations for ETP Connector



## Base Requirements
- public subnet
- private subnet(s)
- IGW, (optional NGW)
- existing routing tables
- AWS API User


# Usage
- configure the data in the "main.tf" --> [2DO: Shift to vars]
- configure your AWS credentials into file ./.aws_creds (Root of the repo, not the TF dir!)
- Run the following commands from within the Terraform dir
  ```bash
  # Initialize Terraform
  terraform init
  
  # Check what would happen
  terraform plan
  
  # Do the rollout
  terraform apply
  ```
  Make sure to follow the on-screen instructions

- To delete everything:
  ```bash
  # Delete everything that was created by TF
  terraform destroy
  ```

## Issues / Not implemented
- remote state (only local state - do not cross collaborate !)