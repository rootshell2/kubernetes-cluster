resource "azurerm_virtual_machine" "kube_master" {
  name                  = "KubeMaster"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.public_nic.id}"]
  vm_size               = "Standard_B2s"

#This will delete the OS disk and data disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-master"
    vhd_uri       = "${azurerm_storage_account.la_storage.primary_blob_endpoint}${azurerm_storage_container.la_cont.name}/osdisk-master.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "master"
    admin_username = "${var.vm_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.vm_username}/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/id_rsa.pub")}"
    }
  }

  tags {
    group = "kube-cluster"
  }
}