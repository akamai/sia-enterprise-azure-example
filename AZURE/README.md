# This scripty will install SIA SC connector into AZURE

# Requirements
## Tools
- helm 
- az (azure cli)

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
cd terraform-scripts
terraform init
```