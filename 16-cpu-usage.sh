#!/bin/bash

CPU_USAGE=$(top | grep -v PID)
CPU_THRESHOLD=0 # By default 75 in projects
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MESSAGE=""

while IFS= read -r line
do 
    USAGE=$(echo $line | awk '{print $9}' )
    PARTITION=$(echo $line | awk '{print $11}')
    if [ $USAGE -ge $CPU_THRESHOLD ]; then
        MESSAGE+="High cpu usage $PARTITION : $USAGE% <br>"
    fi
done <<< $CPU_USAGE

echo -e "Message Body : $MESSAGE"

sh mail.sh "someshwar.sangaraju19@gmail.com" "High cpu usage alert" "High cpu usage" "$MESSAGE" "$IP_ADDRESS" "Monitoring team"

# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5
# TO_TEAM=$6
