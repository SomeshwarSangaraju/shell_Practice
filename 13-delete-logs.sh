#!/bin/bash

LOGS_FOLDER="/var/log/app-logs"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOGS_FILE=$LOGS_FOLDER/$LOG_FILE.log

mkdir -p $LOG_FILE

SOURCE_DIR=/home/ec-user/app-logs

if [ ! -d $SOURCE_DIR -ne 0 ]; then
    echo "ERROR:: $1 file does not exists"
    exit 1
fi

# FILE_TO_DELETE=$(find . -name -type f -mtime +14)


FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath
do
    echo "Deleting the file: $filepath"
    rm -rf $filepath
    echo "Deleted the file: $filepath"
done <<< $FILES_TO_DELETE

