# etp-connector-tf

This repo is meant to support ETP ENG team in order to automate cloud installations for ETP Connector



## Base Requirements
- public subnet
- private subnet(s)
- IGW, (optional NGW)
- existing routing tables
- AWS API User


## Usage
- configure your AWS credentials into file ./.aws_creds (Root of the repo, not the TF dir!) see the [sample file](./.aws_creds-example)
- copy the [example _overwrite](variable-files/example_overwrite.tf) file and configure it to your setup
- Run the following commands from within the `terraform-scripts` direcvtory (make sure to use your individual var file)
  ```bash
  # Initialize Terraform
  terraform init
  
  # Check what would happen
  terraform plan -var-file=../variable-files/mike-akseel_overwrite.tf
  
  # Do the rollout
  terraform apply -var-file=../variable-files/mike-akseel_overwrite.tf
  ```
  Make sure to follow the on-screen instructions.  



- To delete everything:
  ```bash
  # Delete everything that was created by TF
  terraform destroy -var-file=../variable-files/mike-akseel_overwrite.tf
  ```

## Issues / Not implemented
- remote state (only local state - do not cross collaborate !)