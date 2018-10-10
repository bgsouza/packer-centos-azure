#!/bin/bash -eux
sudo su <<HERE

# Network 01
echo "Aply rules in /etc/sysconfig/network"
sudo cat >> /etc/sysconfig/network <<EOF
 NETWORKING=yes
 HOSTNAME=localhost.localdomain
EOF

# Network 02
echo "Aply rules in /etc/sysconfig/-scripts/ifcfg-eth0"
sudo cat >> /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
 DEVICE=eth0
 ONBOOT=yes
 BOOTPROTO=dhcp
 TYPE=Ethernet
 USERCTL=no
 PEERDNS=yes
 IPV6INIT=no
 NM_CONTROLLED=no
EOF

echo "This rule avoids problems when cloning a virtual machine in Microsoft Azure or Hyper-V"
sudo ln -s /dev/null /etc/udev/rules.d/75-persistent-net-generator.rule #Isso também garantirá que todas as mensagens do console sejam enviadas para a primeira porta serial, que pode auxiliar o suporte do Azure com problemas de depuração. Ele também desativa novas convenções de nomenclatura do CentOS 7 para NICs.s.d/75-persistent-net-generator.rules

echo "yum clean all"
sudo yum clean all
echo "ym update"
sudo yum -y update

# Additional kernel parameters for Azure.   
# This will also ensure that all console messages are sent to the first serial port, which can 
# support Azure support with debugging issues. It also disables new CentOS 7 naming conventions for NICs.
echo "Modify GRUB"
sudo sed -i "s/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"rootdelay=300 console=ttyS0 earlyprintk=ttyS0 net.ifnames=0\"/" /etc/default/grub

#rhgb quiet crashkernel=auto
echo "Recompile grup"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    
# install kdump
sudo rpm -e hypervkvpd  ## (may return error if not installed, that's OK)
sudo yum install microsoft-hyper-v

echo "ADD Drivers Hyper-V"
echo 'add_drivers+=”hv_vmbus hv_netvsc hv_storvsc”' >> /etc/dracut.conf
# Recompile o initramfs:
sudo dracut -f -v

echo "Install WALinuxAgent and dependencies"
sudo yum -y install python-pyasn1 WALinuxAgent
sudo systemctl enable waagent

echo "Changes waagent.conf"
sudo sed -i "s/ResourceDisk\.Format=.*/ResourceDisk.Format=y/" /etc/waagent.conf
sudo sed -i "s/ResourceDisk\.Filesystem=.*/ResourceDisk.Filesystem=ext4/" /etc/waagent.conf
sudo sed -i "s/ResourceDisk\.MountPoint=.*/ResourceDisk.MountPoint=\/mnt\/resource/" /etc/waagent.conf
sudo sed -i "s/ResourceDisk\.EnableSwap=.*/ResourceDisk.EnableSwap=ext4/" /etc/waagent.conf
sudo sed -i "s/ResourceDisk\.SwapSizeMB=.*/ResourceDisk.SwapSizeMB=2048/" /etc/waagent.conf

HERE