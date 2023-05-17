#!/bin/bash

echo -e "\e[92mSending DNS request for a CanaryToken. Check the email that will receive the trigger..." 

nslookup canary_token_here
