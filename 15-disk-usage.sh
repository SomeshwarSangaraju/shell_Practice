#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem ) 
DISK_THRESHOLD=75
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MESSAGE=""

while IFS= read -r flinee
do
    USAGE=$(echo $line | awk '{print $6}' | cut -d "%" -f1 )
    PARTITION=$(echo $line | awk '{print $7}')
    if [ $USAGE -gt $DISK_THRESHOLD ]; then
       MESSAGE+="High Disk usage on $PARTITION: $USAGE % <br>" # escaping
    fi

done <<< $DISK_USAGE

echo -e "Message Body: $MESSAGE"