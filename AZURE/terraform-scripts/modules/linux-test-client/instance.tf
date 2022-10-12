resource "azurerm_linux_virtual_machine" "linux-test-client" {
  name                = "${var.ltc-name}-instance"
  resource_group_name = var.resource_group
  location            = var.region
  size                = "Standard_F2"
  admin_username      = "mschiess"
  network_interface_ids = [
    azurerm_network_interface.ltc-if0.id,
  ]

  admin_ssh_key {
    username   = "mschiess"
    public_key = var.ltc-key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}