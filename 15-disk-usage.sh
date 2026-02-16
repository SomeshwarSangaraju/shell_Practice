#!/bin/bash

Disk_Usage=$(df -hT | grep -v Filesystem ) 
Disk_Threshold=75

while IFS= read -r file
do
    # echo "file : $file"
    Usage=$(awk '{print $6}' | cut -d "%" -f1 )
    Partition=$(awk '{print $7}')
    # if [ $Usage -gt $DISK_THRESHOLD ]; then
    #     echo "High disk usage"
    # fi

done <<< $Disk_Usage