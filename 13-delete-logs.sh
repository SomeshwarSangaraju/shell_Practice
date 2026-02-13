#!/bin/bash

LOGS_FOLDER="/var/log/app-logs"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOGS_FILE=$LOGS_FOLDER/$LOG_FILE.log

mkdir -p $LOG_FILE

if [ ! -d $LOG_FOLDER -ne 0 ]; then
    echo "ERROR:: $1 file does not exists"
    exit 1
fi

find . -name $SCRIPT_NAME -type f -mtime +14
