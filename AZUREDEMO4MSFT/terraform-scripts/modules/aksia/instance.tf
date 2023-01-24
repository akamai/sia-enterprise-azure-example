# AK SIA Beta is using Azure Community aka Gallery

resource azurerm_linux_virtual_machine "aksc-instance" {

  name                = "${var.sc-name}-instance"
  resource_group_name = var.resource_group
  location            = var.region
  size                = "Standard_B2s"
  admin_username      = "sc-admin"
  # Akamai Security Connector Appliance expect (TBC)
  # - first: the data (ingress) NIC
  # - second: the mgmt (+ egress) NIC
  network_interface_ids = [
    azurerm_network_interface.sc-netif-mgmt.id,
    azurerm_network_interface.sc-netif-data.id
  ]

  admin_ssh_key {
    username   = "sc-admin"
    public_key = var.sc-key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  # Post-Beta we can now find the Akamai Security Connector image in Azure Community Image
  # The gallery name is static, the following command will give you the image name in the location of your choice
  # % az sig image-definition list-community --public-gallery-name AkamaiSC-25e2ec5b-5d88-4af3-8118-ade3f4ba7ea0 --location eastus
  # To get the URL of the image_id, use the following command:
  # % az sig image-definition show-community --location eastus -i "sky-13965-20221110.45138874-deploy-vhd" --public-gallery-name AkamaiSC-25e2ec5b-5d88-4af3-8118-ade3f4ba7ea0
  # And look for uniqueId
  # ** If no image available in your location, please raise an Akamai Support Ticket with your target location **
  source_image_id = "/communityGalleries/AkamaiSC-25e2ec5b-5d88-4af3-8118-ade3f4ba7ea0/images/Sky-13965-20221110.45138874-deploy-vhd"

  boot_diagnostics {
    storage_account_uri = ""
  }
}