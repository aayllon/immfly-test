#!/bin/bash

set -ex
set -o pipefail

DOMAIN_NAME="immfly-debian10"

wget https://immfly-infra-technical-test.s3-eu-west-1.amazonaws.com/debian10-ssh.img.tar.xz || true
tar -xf debian10-ssh.img.tar.xz
mv debian10-ssh.img assets/
image_path=$(readlink -f assets/debian10-ssh.img)
sed -i "s:\${PATH_TO_VM_DISK_FILE}:${image_path}:" assets/vm.xml

virsh create assets/vm.xml
sleep 10 #Wait until domain is created

IP_ADDRESS=""
#wait until IP is assigned to the VM
while [ "${IP_ADDRESS}" == "" ]; do
  sleep 2
  IP_ADDRESS=$(virsh domifaddr ${DOMAIN_NAME} | awk -F" " '{print $4}' | grep "/" || true)
done

#Remove netmask
IP_ADDRESS=$(echo "${IP_ADDRESS}" | cut -d"/" -f"1")

docker build -t ansible:0.1 ansible/

echo -e "[deploy]\n${IP_ADDRESS}" > ansible/inventory.ini

docker run -v "${PWD}":/work:ro \
      --workdir /work/ansible \
      --network host \
      --rm \
      ansible:0.1 \
      ansible-playbook --private-key /work/assets/rsa \
      -u root deploy.yml

echo "The Clock web server is accessible in http://${IP_ADDRESS}"