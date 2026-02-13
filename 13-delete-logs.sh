#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE=$LOGS_FOLDER/$SCRIPT_NAME.log

mkdir -p $LOGS_FOLDER
# START_TIME=$(date +%s)
# echo "Script started executed at: $START_TIME" | tee -a $LOG_FILE

echo "Script started executed at: $(date)" | tee -a $LOG_FILE

SOURCE_DIR=/home/ec2-user/app-logs

if [ ! -d $SOURCE_DIR ]; then
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

# END_TIME=$(date +%s)
# echo "Script started executed at: $END_TIME" | tee -a $LOG_FILE

# TOTAL_TIME=$(($END_TIME-$START_TIME))
# echo "Script end executed at: $TOTAL_TIME" | tee -a $LOG_FILE
