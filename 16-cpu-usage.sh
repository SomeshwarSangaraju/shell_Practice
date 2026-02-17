#!/bin/bash

CPU_USAGE=$(echo top | grep -v PID)
CPU_THRESHOLD=2 # By default 75 in projects

while IFS= read -r line
do 
    echo "$line"
done <<< CPU_USAGE
