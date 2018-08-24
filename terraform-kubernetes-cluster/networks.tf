resource "azurerm_resource_group" "terraform_rg" {
  name 		= "${var.resource_group_name}"
  location 	= "${var.location}"
}

resource "azurerm_virtual_network" "la_vnet" {
  name 					= "kubevnet"
  address_space 		= ["${var.vnet_cidr}"]
  location 				= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
  
  tags {
	group = "kube-cluster"
  }
}

resource "azurerm_subnet" "la_subnet_1" {
  name 					= "kubesubnet1"
  address_prefix 		= "${var.subnet1_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.la_vnet.name}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
}

resource "azurerm_subnet" "la_subnet_2" {
  name 					= "kubesubnet2"
  address_prefix 		= "${var.subnet2_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.la_vnet.name}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
}
