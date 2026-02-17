#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=75
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MESSAGE=""

while IFS= read -r file
do 
    USAGE=$(echo $file | awk '{print $6}' | cut -d "%" -f1 )
    PARTITION=$(echo $file | awk '{print $7}' )
    if [ $USAGE -gt $DISK_THRESHOLD ]; then
        MESSAGE+="High disk usage on $PARTITION : $USAGE% <br>"
    fi
done <<< $DISK_USAGE

echo -e "$MESSAGE"


sh gmail.sh "Devops Team" "High disk usage" "High disk usage alert" "$MESSAGE" "someshwar.sangaraju19@gmail.com" "$IP_ADDRESS"

# TO_TEAM=$1
# SUBJECT=$2
# ALERT=$3
# MESSAGE_BODY=$4
# TO_ADDRESS=$5
# IP_ADDRESS=$6
