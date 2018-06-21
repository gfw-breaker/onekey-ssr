#!/bin/bash

config_file="/etc/shadowsocksr/config.json"

get_value(){
	key="$1"
	value=$(cat $config_file | jq ".$key" | sed 's/"//g')
	echo $value
}

ss_server_ip=$(get_value server)
ss_server_port=$(get_value server_port)
ss_password=$(get_value password)
ss_method=$(get_value method)
ss_protocol=$(get_value protocol)
ss_obfs=$(get_value obfs)

urlsafe_base64(){
	date=$(echo -n "$1"|base64|sed ':a;N;s/\n/ /g;ta'|sed 's/ //g;s/=//g;s/+/-/g;s/\//_/g')
	echo -e "${date}"
}

ss_link_qr(){
	SSbase64=$(urlsafe_base64 "${ss_method}:${ss_password}@${ss_server_ip}:${ss_server_port}")
	SSurl="ss://${SSbase64}"
	qrencode -o $qr_folder/ss.png -s 2 "${SSurl}"
	echo "${SSurl}" > url.txt
}

ssr_link_qr(){
	SSRprotocol=$(echo ${ss_protocol} | sed 's/_compatible//g')
	SSRobfs=$(echo ${ss_obfs} | sed 's/_compatible//g')
	SSRPWDbase64=$(urlsafe_base64 "${ss_password}")
	#remarkBase64=$(urlsafe_base64 "gfw-breaker [${ss_server_ip}]")
	remarkBase64=$(urlsafe_base64 "账号更新 http://truth.atspace.eu/")
	SSRbase64=$(urlsafe_base64 "${ss_server_ip}:${ss_server_port}:${SSRprotocol}:${ss_method}:${SSRobfs}:${SSRPWDbase64}/?remarks=${remarkBase64}")
	SSRurl="ssr://${SSRbase64}"
	qrencode -o $qr_folder/ssr.png -s 2 "${SSRurl}"
	echo "${SSRurl}" >> url.txt
}


ss_link_qr
ssr_link_qr



