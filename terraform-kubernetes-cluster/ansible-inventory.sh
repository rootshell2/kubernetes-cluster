#!/usr/bin/env bash


master_ip=$(terraform output -json -no-color  | jq '.master_fqdn.value' |  tr -d '"')
worker1_ip=$(terraform output -json -no-color  | jq '.worker1_fqdn.value' |  tr -d '"')
worker2_ip=$(terraform output -json -no-color  | jq '.worker2_fqdn.value' |  tr -d '"')
echo "[masters]
master ansible_host=$master_ip ansible_user=ubuntu

[workers]
worker1 ansible_host=$worker1_ip ansible_user=ubuntu
worker2 ansible_host=$worker2_ip ansible_user=ubuntu


[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'" > ../ansible-kubernetes-cluster/hosts



