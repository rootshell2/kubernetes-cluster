resource "azurerm_public_ip" "la_pip" {
  name 				= "Master-PIP"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation 	= "static"

  tags {
	group = "kube-cluster"
  }
}

resource "azurerm_network_interface" "public_nic" {
  name 		      = "Master-NIC"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.nsg_kube.id}"

  ip_configuration {
    name 			= "MasterPrivate"
    subnet_id 			= "${azurerm_subnet.la_subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.la_pip.id}"
  }
  tags {
	group = "kube-cluster"
  }
}

output "master_fqdn" {
  value = "${azurerm_public_ip.la_pip.ip_address}"
}

resource "azurerm_public_ip" "la_pip_worker1" {
  name 				= "Worker1-PIP"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation 	= "static"

  tags {
	group = "kube-cluster"
  }
}

resource "azurerm_network_interface" "public_worker1_nic" {
  name 		      = "Worker1-NIC"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.nsg_kube.id}"

  ip_configuration {
    name 			= "Worker1Private"
    subnet_id 			= "${azurerm_subnet.la_subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.la_pip_worker1.id}"
  }
  tags {
	group = "kube-cluster"
  }
}

output "worker1_fqdn" {
  value = "${azurerm_public_ip.la_pip_worker1.ip_address}"
}

resource "azurerm_public_ip" "la_pip_worker2" {
  name              = "Worker2-PIP"
  location          = "${var.location}"
  resource_group_name       = "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation  = "static"

  tags {
    group = "kube-cluster"
  }
}

resource "azurerm_network_interface" "public_worker2_nic" {
  name            = "Worker2-NIC"
  location        = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.nsg_kube.id}"

  ip_configuration {
    name            = "Worker2Private"
    subnet_id           = "${azurerm_subnet.la_subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id    = "${azurerm_public_ip.la_pip_worker2.id}"
  }
  tags {
    group = "kube-cluster"
  }
}

output "worker2_fqdn" {
  value = "${azurerm_public_ip.la_pip_worker2.ip_address}"
}
