# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
# For the Image SKU, please see:
# https://learn.microsoft.com/en-us/azure/virtual-machines/windows/windows-desktop-multitenant-hosting-deployment
# PowerShell:
# Get-AzVmImageSku -Location 'West US' -PublisherName 'MicrosoftWindowsDesktop' -Offer 'Windows-11'
# Azure CLI:
# az vm image list --all --offer windows-11 --output table

resource "azurerm_network_interface" "nic-client-windows11" {
  name                = "nic-client-windows11"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "client-windows11" {
  name                = "client-windows11"
  computer_name       = "w11-client" # max 15 characters
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = "akamai"
  admin_password      = var.w11_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic-client-windows11.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pro"
    version   = "latest"
  }
}