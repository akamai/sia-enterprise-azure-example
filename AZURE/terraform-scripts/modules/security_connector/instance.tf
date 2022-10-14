resource azurerm_linux_virtual_machine "security-connector" {
  name                = "${var.sc-name}-instance"
  resource_group_name = var.resource_group
  location            = var.region
  size                = "Standard_B2s"
  admin_username      = "sc-admin"
  network_interface_ids = [
    azurerm_network_interface.sc-if0.id,
    azurerm_network_interface.sc-if1.id
  ]

  admin_ssh_key {
    username   = "sc-admin"
    public_key = var.sc-key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_id = var.sc-image-id
  boot_diagnostics {
    storage_account_uri = ""
  }
}