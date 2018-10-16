#!/bin/bash -eux
sudo waagent -force -deprovision
export HISTSIZE=0
exit