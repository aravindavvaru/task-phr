all: deploy_server add_inventory wait_120s provision_ansible


deploy_server:
	cd deliverable/terraform && \
	terraform init && \
	terraform plan && \
	terraform apply

wait_120s:
	  sleep 120

add_inventory:
	sh create_ansible_inventory.sh

provision_ansible:
	cd deliverable/ansible && ansible-playbook -i inventory provision.yml

destroy:
	cd deliverable/terraform && \
	terraform destroy 

collections:
	ansible-galaxy collection install community.docker
	ansible-galaxy collection install ansible.posix





