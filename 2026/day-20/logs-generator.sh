#!/bin/bash
set -eou pipefail
read -p $'select service which you want to check logs:\n1.Nginx \n2.docker \n3.ssh:' s
service(){
       tstamp=$(date +%Y%m%d_%H:%M)
      
       if [ $1 -eq '1' ];
       then
	       $(journalctl -u nginx | awk '{print NR , $0 }' >> nginx_errorlog_$tstamp.log)
       fi
       if [ $1 -eq '2' ];
       then
	       $(journalctl -u docker | awk '{print NR , $0 }' >> docker_errorlog_$tstamp.log)
       fi
       if [ $1 -eq '3' ];
       then
	       $(journalctl -u ssh | awk '{print NR , $0 }' >> ssh_errorlog_$tstamp.log)
       fi
       echo "The service is $s $tstamp"
}

if [ $s -gt '3' ];
then
	echo "Enter correct value:"
	exit 0

else
	service $s
fi

