rm -rf ./output-vhd/MyCustomISO.vhd
VBoxManage clonehd ./output-virtualbox-iso/packer-centos-7-x86_64-disk001.vmdk --format VHD ./output-vhd/MyCustomISO.vhd --variant Fixed