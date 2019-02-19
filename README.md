# Packer Centos Azure
Template Packer for generate custom Centos7 with Hardening image to use in Azure

## Generate IMAGE
 - **manual-vhd**: Generate custom VHD based in centos7  => publish blob in storage => create image (genaralized)
 - **marketplace**: Generate custom VHD based in centos7 of the azure-marketplace  => create image (genaralized)

## How to Use
 - **manual-vhd**: 
   - cd <path-to-clone>
   - $ /usr/local/packer build -var 'version=1.0' centos.json
   - $ . scripts/azure/vhd/deploy-vhd-azure.sh #to upload and create disk and VM Temp
   - $ . scripts/azure/vhd/make-image.sh # Get VM temp and convert in valid IMAGE type
- **marketplace**
  - cd <path-to-clone>
  - $ /usr/local/packer build -var 'version=1.0' centos.json


## Dependencies
 * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
 * [AZ-cli](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli?view=azure-cli-latest)
 * [Packer](https://www.packer.io/downloads.html)

## References
* Project based in [packer-alpine-azure](https://github.com/tomconte/packer-alpine-azure)
* Project used [ansible-hardening](https://github.com/openstack/ansible-hardening)

## Author
Bruno Gomes de Souza <bruno@bgsouza.com> [![StackShare](https://img.shields.io/badge/tech-stack-0690fa.svg?style=flat)](https://stackshare.io/bgsouza/profile)
