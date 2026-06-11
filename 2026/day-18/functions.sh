#!/bin/bash



greet() {
	echo "Hello $1"
}


#greet "Shubham"


check_disk(){
	(df -h /)
}

check_memory(){
	(free -h)
}


check_disk
check_memory
