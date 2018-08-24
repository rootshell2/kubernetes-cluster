1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [Terraform Configuration](#terraform-configuration)
4. [Ansible Configuration](#ansible-configuration)
<br/>

<a name="introduction"/>

## Introduction

*  Automated scripts to provision a Kubernetes cluster on the Azure cloud, based on [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com).
*  These scripts provision a Kubernetes cluster. The Kubernetes cluster has 1 master VMs and 2 node VMs, these numbers can also be configured when launching the Terraform script. 
<br/>

<a name="getting-started"/>

## Getting Started

### General Requirements:

* [Docker](https://docs.docker.com/engine/installation/)

* Instructions for installing Docker on Ubuntu: 
```
https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
```

### Create the service principal:

[Authenticating a service principal with Azure Resource Manager](https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html).

* Export credentials through environment variables:

```console
$ export AZURE_CLIENT_ID         = "YOUR_AZURE_CLIENT_ID"
$ export AZURE_CLIENT_SECRET     = "YOUR_AZURE_CLIENT_SECRET"
$ export AZURE_SERVICE_PRINCIPAL = "YOUR_AZURE_SERVICE_PRINCIPAL"
$ export AZURE_SUBSCRIPTION_ID   = "YOUR_AZURE_SUBSCRIPTION_ID"
$ export AZURE_TENANT_ID         = "YOUR_AZURE_TENANT_ID"
```

### Setup


* Cleaning the environment:

```console
$ make clean
```

* Create the environment for execution: 

```console
$ make setup
```

### Spin up infrastructure:

* Initialize a working directory containing Terraform configuration files:

```console
$ make terraform-init
```

* Create an execution plan: 

```console
$ make terraform-plan
```

* Building the Infrastructure:

```console
$ make terraform-apply
```

### Create a Kubernetes cluster Using Kubeadm

* Create a hosts file containing inventory information such as the IP addresses from Terraform output:

```console
$ make ansible-inventory
```
* Execute the master playbook:

```console
$ make ansible-playbook 
```
<br/>

<a name="terraform-configuration"/>

## Terraform Configuration (Configuration Orchestration)


**File** | **Content**
------------ | -------------
**variables.tf** | Configure Azure Provider as well as declare all the variables that we will use in all our Terraform configurations.
**var_values.tfvars** | Assign values to variables. Terraform automatically loads them to populate variables.
**networks.tf** | Instructions for creating the entire network infrastructure of the project. In this file the main VNET is created, the routes and the subnets for the VMs.
**storage.tf** | Storage account with a container to store VHDs of Virtual Machines.
**security_group.tf** | This file contains inbound and outbound rules for traffic flow.
**vm-.tf** | Terraform configuration to provision the VMs.
**pip_nic.tf** | Public IP address to connect to the VMs from the internet.
**ansible-inventory.sh** | Creates Ansible inventory from Terraform output.

<a name="ansible-configuration"/>

## Ansible Configuration (Configuration Management)

**File** | **Content**
------------ | -------------
**1-dependencies.yml** | Installing Kubernetes' Dependencies. 
**2-master.yml** | Setting Up the Master Node.
**3-workers.yml** | Setting Up the Worker Nodes. 
**hosts** | Host inventories.
**list.yml** | Master playbook. The plays and tasks in each playbook listed will be run in the order they are listed.
<br/>

*  **Contact**

```
   E-mail: rootshell2@gmail.com
```
