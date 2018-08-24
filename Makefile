.DEFAULT_GOAL := help                                                                                                                                                                           

user ?= $(shell whoami)
docker_ssh_opts = -v $(HOME)/.ssh:/root/.ssh:ro

base-docker-run = docker run \
	--rm \
	-e ARM_CLIENT_ID=$(AZURE_CLIENT_ID) \
	-e ARM_CLIENT_SECRET=$(AZURE_CLIENT_SECRET) \
	-e ARM_SUBSCRIPTION_ID=$(AZURE_SUBSCRIPTION_ID) \
	-e ARM_TENANT_ID=$(AZURE_TENANT_ID) \
	-e AZURE_CLIENT_ID=$(AZURE_CLIENT_ID) \
	-e AZURE_CLIENT_SECRET=$(AZURE_CLIENT_SECRET) \
	-e AZURE_SECRET=$(AZURE_CLIENT_SECRET) \
	-e AZURE_SERVICE_PRINCIPAL=$(AZURE_SERVICE_PRINCIPAL) \
	-e AZURE_SUBSCRIPTION_ID=$(AZURE_SUBSCRIPTION_ID) \
	-e AZURE_TENANT=$(AZURE_TENANT_ID) \
	-e AZURE_TENANT_ID=$(AZURE_TENANT_ID) \
	-v $(shell pwd):/kube-cluster \
	$(docker_ssh_opts) \

ansible-docker-run = $(base-docker-run) \
	-w  /kube-cluster/ansible-kubernetes-cluster \
	-it kube-cluster

terraform-docker-run = $(base-docker-run) \
	-w  /kube-cluster/terraform-kubernetes-cluster \
	-it kube-cluster

.PHONY: terraform-init
terraform-init:
	$(terraform-docker-run) \
		terraform init . \

.PHONY: terraform-plan
terraform-plan:
	$(terraform-docker-run) \
	terraform plan -var-file=var_values.tfvars

.PHONY: terraform-apply
terraform-apply:
	$(terraform-docker-run) \
	terraform apply -var-file=var_values.tfvars

.PHONY: terraform-destroy
terraform-destroy:
	$(terraform-docker-run) \
	terraform destroy -var-file=var_values.tfvars

.PHONY: ansible-inventory
ansible-inventory:
	$(terraform-docker-run) \
	bash ansible-inventory.sh

.PHONY: ansible-playbook
ansible-playbook:
	$(ansible-docker-run) \
	ansible-playbook list.yml \
	-i hosts

.PHONY: clean
clean: 
	find . -name ".terraform" -exec rm -rf {} +
	#docker rmi kube-cluster

.PHONY: setup
setup: ## Setup development environment
	@echo "Building docker image"
	docker build . -t kube-cluster
	@echo "Done!"
