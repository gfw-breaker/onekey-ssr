#!/bin/bash

## install dependencies
yum install -y vim wget unzip net-tools openssl-devel python bind-utils


## install ssr & bbr
unzip shadowsocksr.zip
cp -R shadowsocksr /usr/local/shadowsocksr


## enable ssr service
cp ssr /etc/init.d/ssr
chmod +x /etc/init.d/ssr
chkconfig ssr on
service ssr start


## timezone setting 
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
chkconfig iptables off
service iptables stop

