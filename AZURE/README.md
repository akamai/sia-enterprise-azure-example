# This scripty will install SIA SC connector into AZURE

Azure docs: https://collaborate.akamai.com/confluence/pages/viewpage.action?spaceKey=ESE&title=SC+Setup


# Requirements

## Tools

- `terraform`, https://developer.hashicorp.com/terraform/downloads
- `az`, Azure CLI - https://learn.microsoft.com/en-us/cli/azure/

## Prep

```bash
az login
```
authenticate to the appropriate acocunt

Check accounts & Select subscription
```bash
az account list -o table
```

Switch to subscription ID
```bash
az account set --subscription <ID>
```

Initialize the TF repo

```bash
cd AZURE/terraform-scripts
terraform init
```