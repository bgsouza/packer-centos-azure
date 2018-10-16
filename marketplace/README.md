# Packer Centos Azure
Template Packer for generate custom Centos7 image (using marketplace) with ardening to use in Azure

Project used [ansible-hardening](https://github.com/openstack/ansible-hardening)

# Dependencies
 * [AZ-cli](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli?view=azure-cli-latest)
 * [Packer](https://www.packer.io/downloads.html)

# How Use

- cd <path-to-clone>
- $ /usr/local/packer build -var 'version=1.0' centos.json
