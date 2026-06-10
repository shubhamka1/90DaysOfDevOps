#!/bin/bash


a=(curl wget nginx yum)
#a = 2

for i in ${a[@]};
do
	if dpkg -s "$i" >/dev/null 2>&1 
	then
		echo "Package $i already installed , no need to install"
	else
		#$(sudo apt-get install -y $i)
		echo "package $i installed Successfully"
	fi
done;
echo "packages are ${a[2]}" 
