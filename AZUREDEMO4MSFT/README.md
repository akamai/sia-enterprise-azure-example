# Akamai SIA Cloud Security Connector<!-- omit in toc -->

Demo prepared for Microsoft
January 2023

## Table of contents<!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Target architecture](#target-architecture)
- [Deploying the demo](#deploying-the-demo)
  - [Terraform for the heavy lifting](#terraform-for-the-heavy-lifting)
  - [Configure your SIA Enterprise Security Connector](#configure-your-sia-enterprise-security-connector)
- [Demo from within the environment](#demo-from-within-the-environment)

## Prerequisites

- Microsoft [Azure Account](https://azure.microsoft.com) with an empty Resource Group
- Akamai SIA Enterprise account ([free trial]([#](https://www.akamai.com/products/secure-internet-access-enterprise)))
- A computer with Azure CLI `az` and Terraform
- A Remote Desktop Client

## Target architecture

TODO: Insert diagram here

## Deploying the demo

### Terraform for the heavy lifting

It takes between 5 and 10 minutes to fully populate a Resource Group

```bash
# Customize to your own Terraform variables
# Use terraform-scripts/variables.tf as a template
MYTFVAR="../variable-files/androcho-jan23-demo.tf"

# Terraform standard commands
terraform init
terraform plan -var-file=$MYTFVAR
terraform apply -var-file=$MYTFVAR

# Display the public IP address you need to connect to
# to access the Windows Client machine over RDP
terraform output

# And once the demo is over
terraform destroy -var-file=$MYTFVAR
```

### Configure your SIA Enterprise Security Connector

TODO: write instructions, outline being:

- Declare/Activate the Security Connector
- Create a Location, Policy

## Demo from within the environment

1. Connect to the Windows Client with your RDP client
    - RDP machine: `<Firewall_Public_IP>:30001`
    - Username: `akamai`
    - Password: `<As defined in your $MYTFVAR>`
2. Open Microsoft Edge
3. TBD
