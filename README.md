# Packer Centos Azure
Template Packer for generate custom Centos7 image to use in Azure

Project based in [packer-alpine-azure](https://github.com/tomconte/packer-alpine-azure)

# Dependencies
 * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
 * [AZ-cli](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli?view=azure-cli-latest)
 * [Packer](https://www.packer.io/downloads.html)

# How Use

- cd <path-to-clone>
- $ /usr/local/packer build -var 'version=1.0' centos.json
- $ . scripts/azure/vhd/deploy-vhd-azure.sh #to upload and create disk and VM Temp
- $ . scripts/azure/vhd/make-image.sh # Get VM temp and convert in valid IMAGE type

# Todo
implementation of the [ansible hardening](https://github.com/openstack/ansible-hardening)
