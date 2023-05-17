#!/bin/bash

echo -e "\e[92mCalling large numbers of large domains to simulate tunneling via DNS..." 

dig -f queries.txt > /dev/null 2>&1
