#!/bin/bash

Disk_Usage=$(df -hT | grep -v Filesystem ) 
Disk_Threshold=75
Message=""

while IFS= read -r flinee
do
    Usage=$(echo $line | awk '{print $6}' | cut -d "%" -f1 )
    Partition=$(echo $line | awk '{print $7}')
    if [ $Usage -gt $DISK_THRESHOLD ]; then
       message+=$PARTITION : $Usage
    fi

done <<< $Disk_Usage