/* Configure Azure Provider and declare all the Variables that will be used in Terraform configurations */
provider "azurerm" {}

variable "location" {
  description = "The default Azure region for the resource provisioning"
}

variable "resource_group_name" {
  description = "Resource group name that will contain various resources"
}

variable "vnet_cidr" {
  description = "CIDR block for Virtual Network"
}

variable "subnet1_cidr" {
  description = "CIDR block for Frontend Subnet within a Virtual Network."
}

variable "subnet2_cidr" {
  description = "CIDR block for Backend Subnet within a Virtual Network."
}

variable "vm_username" {
  description = "Enter admin username to SSH into Linux VM"
}

variable "vm_password" {
  description = "Enter admin password to SSH into VM"
}
