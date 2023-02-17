# Find region with Azure CLI:
# az account list-locations -o table
region = "westus3"

# This resource group must be created manually prior to Terraform
resource_group = "androcho-SIA-demo-012"

# Windows Client admin password
w11_admin_password = "4k4m4!l0V3sMsFt"

# Who can access your lab
allow_list  = [
  "174.127.243.153/32",
]

# How should we provision the Azure Firewall rules?
# Possible values:
# - `classic` for classic rules
# - `policy` for Policy (Azure Firewall Manager)
azure_firewall_rule_mode = "classic"

# SSH Public Key to manage the Security Connector Console
sc-key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDB1KxxjpL0ZNWq7ovOhDnPwPdTbBnwMFC0DPS/LIxAHUA9eTljmKJRQxWPdCIY1v6AWvGPx//ZkcntGwu4M+0F3JnrDH5TP/1AxXJW5F8Ui0Ja0zatpAAIB8sqPTb4Aun7V6Ab51agOOJ4EtU4E4KskrFhSfjSYTAXNs48fO5yh/H+DOwoA6qRgjzPu6HwYH0pROKx64kXLoW8FuP07ifYnxTdnNT1W77PcsM/LzGcyW7JIPT3fzBwjXOcetDTz6FwlVwZHaEaoZaVNByHHsdDx4cg8tyV42yNfThTEpdXhaRoE9hMXzUsy7Hck6j/Mncb8dmAC+S7shz1OrWX3Kxf androcho-external-2023-01-09"
