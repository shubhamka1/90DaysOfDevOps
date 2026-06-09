#!/bin/bash



read -p "Enter file name: " fname
#read -p "Enter your Role:" role
name="/home/shubham/$fname"
echo "Hello I'm $name "

if [ -f $name ]; then
	echo "file exist!"

#elif [ "$num" -eq 0 ]; then

#	echo "Number is zero!"
else
	echo "file doesn't exist!"

fi


