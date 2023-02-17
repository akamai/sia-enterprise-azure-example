# Find region with Azure CLI:
# az account list-locations -o table
region = "westus3"

# This resource group must be created manually prior to Terraform
resource_group = "my_resource_group"

# Windows Client admin password
w11_admin_password = "Ak4m4!l0V3sMsFt"

# From where you can access your lab
allow_list  = [
  "1.2.3.4/32",
]

# How should we provision the Azure Firewall rules?
# Possible values:
# - `classic` for classic rules
# - `policy` for Policy (Azure Firewall Manager)
azure_firewall_rule_mode = "classic"

# SSH Public Key to manage the Security Connector Console
sc-key = "ssh-rsa ..."
