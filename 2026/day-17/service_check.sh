#!/bin/bash

read -p "Enter the service name:" service

read -p "Choose below options for service 
1. To check service status 
2. To check last 10 lines of service logs
3. Exit :" flag

echo -e "the name of service is $service \nflag is $flag"


if [ $flag -eq 1 ]; then
	systemctl status $service
elif [ $flag -eq 2 ]; then
	journalctl -u $service | tail -n 10
else
	exit 0
fi
