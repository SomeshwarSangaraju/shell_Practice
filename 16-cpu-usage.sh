#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=75
MESSAGE=""

while IFS= read -r file
do 
    USAGE=$(echo $file | awk '{print $6}' | cut -d "%" -f)
    PARTITION=$(echo $file | awk '{print $7}')
    if [ $USAGE -gt $DISK_THRESHOLD ]; then
        MESSAGE+=" High disk $PARTITION : $USAGE"
    fi
done <<< $DISK_USAGE