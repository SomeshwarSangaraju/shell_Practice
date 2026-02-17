#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=75

while IFS= read -r file
do 
    echo "$file"
    
done <<< $DISK_USAGE