resource "azurerm_linux_virtual_machine" "linux-test-client" {
  name                = "example-machine"
  resource_group_name = var.resource_group
  location            = var.region
  size                = "Standard_F2"
  admin_username      = "mschiess"
  network_interface_ids = [
    azurerm_network_interface.ltc-if0.id,
  ]

  admin_ssh_key {
    username   = "mschiess"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsN42cJzHag0LJQUN3HXezvVQCgPZGM+IETnseTx0ZwxD7uL/j2E65MODl3PPy3O43dv3SzCrZiyT3KsTe5VYsiO27xgOtpimyuVJjzaNEDRRqu6bqQjApYLMxi9uddfqp2GgB69zPqmAHgqvNXlXtNDhx19JCYUalDvJ9a5dIaMk19ZWo6e9/NMzWhW5WXVQUqiEgtuE7Sc2eTEOtSgaEYO/JZjWOLNQum2qxpRgiX9ETkqA5dCwmdEAN/E7CoN30BwRYk1ROzAgJeSFpQgQ+VaVbCAOpswGsrinxficvnvTVckRvIa8+ul4AbmtHhd8SPney1jF1swtMt0xUSELh mschiess-external-20220905"
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