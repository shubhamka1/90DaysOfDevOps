#!/bin/bash

set -euo pipefail
b=$1

compress(){
	a=$(find $b -type f -atime +7 -name "*.log" | wc -l)
	echo "Number of files to be compressed: $a"
	find $b -type f -atime +7 -name "*.log" -exec gzip '{}' /;
}


delete(){
	c=:$(find $b -type f -name "*.gz" -atime +30 | wc -l)
	echo "Number of files to be deleted:$c"
	find $b -type f -name "*.gz" -atime +30 -delete
}

if [ -d "$1" ]; then
	echo "call function"
	compress
	delete
else
	echo "Enter correct directory"
fi
