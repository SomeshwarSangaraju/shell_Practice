#!/bin/bash

Disk_Usage=$(df -hT | grep -v Filesystem ) 
Disk_Threshold=75

while IFS=read -r line
do
    echo "line : $line"
done <<< $Disk_Usage