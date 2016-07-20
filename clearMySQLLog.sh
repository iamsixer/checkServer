#/bin/bash

DeleteNum=`cat /var/log/mysql/mysql.log | grep delete | wc -l | awk '{print int($1)}'`
DropNum=`cat /var/log/mysql/mysql.log | grep "DROP TABLE" | wc -l | awk '{print int($1)}'`

if [ $DeleteNum -lt 1] && [ $DropNum -lt 1 ];then
	`echo "" > /var/log/mysql/mysql.log`;
	`echo 0 > ~/checkServer/delete.log`;
	`echo 0 > ~/checkServer/drop.log`;
fi

