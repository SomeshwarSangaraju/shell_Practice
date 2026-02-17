#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=2
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MESSAGE=""

while IFS= read -r file
do 
    USAGE=$(echo $file | awk '{print $6}' | cut -d "%" -f1 )
    PARTITION=$(echo $file | awk '{print $7}' )
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
        MESSAGE+="High disk usage on $PARTITION : $USAGE% <br>"
    fi
done <<< $DISK_USAGE

echo -e "Message Body: $MESSAGE"


sh mail.sh "someshwar.sangaraju19@gmail.com" "High Disk Usage Alert" "High Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team"

# TO_TEAM=$1
# SUBJECT=$2
# ALERT=$3
# MESSAGE_BODY=$4
# TO_ADDRESS=$5
# IP_ADDRESS=$6
