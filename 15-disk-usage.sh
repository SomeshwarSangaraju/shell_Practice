#!/bin/bash

usage=$(df -hT | grep -v Filesystem ) 

# if [ $usage -gt 80 ]; then
#     echo "High disk alert $usage"
# fi