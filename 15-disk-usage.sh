#!/bin/bash

Disk_Usage=$(df -hT | grep -v Filesystem ) 
Disk_Threshold=75

while IFS=read -r file
do
    echo "file : $file"
done <<< $Disk_Usage