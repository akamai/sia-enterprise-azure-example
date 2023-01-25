# Akamai SIA Cloud Security Connector with Azure Firewall<!-- omit in toc -->

## About this document

This document walk through the build of a lab showing how you can protect your workload running in Azure with Akamai Secure Internet Access. Through a tight integration with Azure Firewall, you will be able to block threat directly at the DNS level.

Last update: January 2023, 23th

Authors:
- Antoine Drochon (androcho@akamai.com)
- Mike Schiessl (mschiessl@akamai.com)

## Table of contents<!-- omit in toc -->

- [About this document](#about-this-document)
- [Prerequisites](#prerequisites)
- [Target architecture](#target-architecture)
- [Deploying the Akamai Security Connector + Azure Firewall demo](#deploying-the-akamai-security-connector--azure-firewall-demo)
  - [Terraform for the heavy lifting](#terraform-for-the-heavy-lifting)
  - [Configure your SIA Enterprise Security Connector](#configure-your-sia-enterprise-security-connector)
    - [Declare/Activate the Security Connector](#declareactivate-the-security-connector)
    - [Create a Location, Policy](#create-a-location-policy)
- [Demo from within the environment](#demo-from-within-the-environment)

## Prerequisites

- Microsoft [Azure Account](https://azure.microsoft.com) with an empty Resource Group
- Akamai SIA Enterprise account ([free trial]([#](https://www.akamai.com/products/secure-internet-access-enterprise)))
- A computer with Azure CLI `az` and Terraform
- A Remote Desktop Client

## Target architecture

TODO: Insert diagram here

## Deploying the Akamai Security Connector + Azure Firewall demo

### Terraform for the heavy lifting

It takes between 5 and 10 minutes to fully populate a Resource Group.
See https://techdocs.akamai.com/etp/docs/deploy-security-connector#deploy-security-connector-on-microsoft-azure for the step by step process if you decide to go manually.

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

#### Declare/Activate the Security Connector

- Get the Security Connector Activation Code from Akamai Control Center / API
- SSH to `<AZFirewall_Public_IP>:30002`

#### Create a Location, Policy

## Demo from within the environment

1. Connect to the Windows Client with your RDP client
    - RDP machine: `<AZFirewall_Public_IP>:30001`
    - Username: `akamai`
    - Password: `<As defined in your $MYTFVAR>`
2. Open Microsoft Edge
3. TBD
