# packer-centos-azure
Template Packer for generate custom Image in Azure

# Dependencies
AZ-cli
Packer

# How Use

- cd <path-to-clone>
- $ /usr/local/packer build -var 'version=1.0' centos.json
- $ . scripts/azure/vhd/deploy-vhd-azure.sh #to upload and create disk and VM Temp
- $ . scripts/azure/vhd/make-image.sh # Get VM temp and convert in valid IMAGE type
