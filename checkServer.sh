#!/bin/bash
# Aleen42
# obtain IP address
# IP=`ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk -F ' ' '{print $2}'| awk -F':' '{print $2}'| head -n 1` 
# percent
NORMAL_CHECK=$1
MAX_mem=95
MAX_swap=20
MAX_cpu=70
DELAY=1
COUNT=1

sh_command=`which sh`
top_command=`which top`
sar_command=`which sar`
iostat_command=`which iostat`
free_command=`which free`

checkServer()
{
	# record files
	`$sh_command /home/checkServer/monitor.sh`

	GENERAL_CHECK=`$top_command -b -d ${DELAY} -n ${COUNT}`
	GENERAL_CHECK_TITLE="===============================General Check================================"
	GENERAL_CHECK_TAIL="============================================================================="
	
	CPU_CHECK=`$sar_command -u ${DELAY} ${COUNT}`
	CPU_CHECK_TITLE="===================================Cpu Check==================================="
	CPU_CHECK_TAIL="============================================================================="

	MEM_CHECK=`$free_command -m -s ${DELAY} -c ${COUNT}`
	MEM_CHECK_TITLE="===================================Mem Check==================================="
	MEM_CHECK_TAIL="============================================================================="
	
	IO_CHECK=`$iostat_command ${DELAY} ${COUNT}`
	IO_CHECK_TITLE="=================================IO Check======================================"
	IO_CHECK_TAIL="============================================================================"

	NETWORK_CHECK=`$sar_command -n DEV ${DELAY} ${COUNT}`
	NETWORK_CHECK_TITLE="=============================Network Check====================================="
	NETWORK_CHECK_TAIL="============================================================================"
	
	EMAIL_CONTENT="$EMAIL_CONTENT$GENERAL_CHECK_TITLE\n$GENERAL_CHECK\n$GENERAL_CHECK_TAIL\n"
	EMAIL_CONTENT="$EMAIL_CONTENT$CPU_CHECK_TITLE\n$CPU_CHECK\n$CPU_CHECK_TAIL\n"
	EMAIL_CONTENT="$EMAIL_CONTENT$MEM_CHECK_TITLE\n$MEM_CHECK\n$MEM_CHECK_TAIL\n"
	EMAIL_CONTENT="$EMAIL_CONTENT$IO_CHECK_TITLE\n$IO_CHECK\n$IO_CHECK_TAIL\n"
	EMAIL_CONTENT="$EMAIL_CONTENT$NETWORK_CHECK_TITLE\n$NETWORK_CHECK\n$NETWORK_CHECK_TAIL\n"
	# send emails
	echo "$EMAIL_CONTENT" | `which mutt` -s $1 aleen42@vip.qq.com
	echo "$EMAIL_CONTENT" | `which mutt` -s $1 15521028248@163.com
}

# 物理内存  
# 1p: 取一行， 2：第二行
total_mem = `free | sed -n "2, 1p" | awk '{print $2}'`
free_mem = `free | sed -n "3, 1p" | awk '{print $4}'`
Mem=$free_mem/$total_mem*100
# 虚拟内存
#SWAP=`free | awk '/Swap/ {print int($3/$2*100)}'`
# CPU占用率
Cpu=`sar | awk '/Average/ {print int($3)}'`

if [ $Mem -gt $MAX_mem ];then
	EMAIL_CONTENT="Memory Warning! Current memory of Voice-in Server is $Men%, which is over than the max_mem_value $MAX_mem%\n"
	$(checkServer "Memory_Warning!");
fi

if [ $Cpu -gt $MAX_cpu ];then
	EMAIL_CONTENT="CPU Warning! Current cpu of Voice-in Server is $Cpu%, which is over than the max_cpu_value $MAX_cpu%\n"
	$(checkServer "CPU_Warning!");
fi

if $NORMAL_CHECK;[ $Cpu -lt $MAX_cpu ];[ $Mem -lt $MAX_mem ];then
	$(checkServer "Check_Server_Log");
fi
