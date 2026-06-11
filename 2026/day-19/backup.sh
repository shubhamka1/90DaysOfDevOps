#!/bin/bash
set -eou pipefail


source="/home/shubham/"
destination="/home/backups/"
nameoftar="home_bkp"
timestamp=$(date +%Y%m%d_%H:%M)
compress(){
	tar -cf "$destination/home_shubham_bkp_$timestamp.tar" "$source"
	#echo "$destination/home_shubham_bkp_$timestamp.tar"
	gzip "$destination/home_shubham_bkp_$timestamp.tar"
}

rotation(){

	a=$(ls -lt "$destination" | awk 'NR > 5 {print "/home/backups/"$9}')
	rm $a
	



}


compress

echo "bkp created successfully" 

if [ $(ls -l "$destination" | wc -l) -gt 14 ]; then
	rotation
fi

