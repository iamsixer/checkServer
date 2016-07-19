#/bin/bash

DeleteNum=`cat /var/log/mysql/mysql.log | grep delete | wc -l | awk '{print int($1)}'`

if [ $DeleteNum -lt 1 ];then
	`echo "" > /var/log/mysql/mysql.log`;
fi

