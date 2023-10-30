#!/bin/bash

echo -e "\e[92mCreating server with busybox!"
echo -e "\e[91mServer running on port 8080..."

busybox httpd -f -p 8080 -h .
