#!/bin/bash
# Copyright (c) 2025 RPanel
# All rights reserved.

if command -v apt-get >/dev/null; then
apt update -y
apt-get install build-essential libncurses5-dev libpcap-dev make zip unzip wget -y
elif command -v yum >/dev/null; then
yum update -y
yum install gcc-c++ libpcap-devel.x86_64 libpcap.x86_64 "ncurses*"
fi
sudo wget -O /root/nethogs.zip https://github.com/RmnJL/nethogs-json/archive/refs/heads/main.zip
unzip /root/nethogs.zip
mv -f /root/nethogs-json-master /root/nethogs
cd /root/nethogs/
chmod 744 /root/nethogs/determineVersion.sh
sudo make install
hash -r
cp /usr/local/sbin/nethogs /usr/sbin/nethogs -f
rm -fr /root/nethogs /root/nethogs.zip
sudo setcap "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+pe" /usr/local/sbin/nethogs
