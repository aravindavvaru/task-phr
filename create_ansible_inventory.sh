#!/bin/bash

cd "${PWD}"/deliverable/terraform
host_ip=$(terraform show -json terraform.tfstate | jq '.values.root_module.resources[] | select(.address=="kamatera_server.servera") | .values.public_ips[0]' | sed 's/\"//g')

cat > ../ansible/inventory << EOF 
[all]
${host_ip} 

[all:vars]
ansible_connection=ssh
ansible_user=root
EOF