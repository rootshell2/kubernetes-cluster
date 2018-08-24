resource "azurerm_network_security_group" "nsg_kube" {
  name 					= "kube-cluster-nsg"
  location 				= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"

  security_rule {
	name 						= "AllowAll"
	priority 					= 100
	direction 					= "Inbound"
	access 						= "Allow"
	protocol 					= "*"
	source_port_range          	= "*"
    destination_port_range     	= "*"
    source_address_prefix      	= "*"
    destination_address_prefix 	= "*"
  }
  tags {
	group = "kube-cluster"
  }
}