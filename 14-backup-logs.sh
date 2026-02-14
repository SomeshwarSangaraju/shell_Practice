#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR:: please run with root privilages"
    exit 1
fi

SOURCE_DIR=$1
DES_DIR=$2
DAYS=$(3:-14) 


if [$# - lt 2 ]; then
    echo "pass two arguments"
fi

if [ -d $SOURCE_DIR ]; then
    echo "ERROR:: please run with root privilages"
    exit 1
fi

if [ -d $DES_DIR ]; then
    echo "ERROR:: please run with root privilages"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime $DAYS)

if [ ! -z "${FILES}" ]; then
    echo "files found"
    TIME_STAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME=$DES_DIR/$TIME_STAMP.zip"
    find $SOURCE_DIR -name "*.log" -type f -mtime $DAYS | zip -@ -j $ZIP_FILE_NAME
    if [ -f $ZIP_FILE_NAME ]; then
        while IFS=read -r filepath
        do
            echo "deleting the file $filepath"
            rm -rf $filepath
            echo "deleted file $filepath"
        done <<< $FILES
    else
        echo "$ZIP_FILE_NAME not found"
        exit 1
    fi
else
    echo "not found"
fi

# if [ ! -z "${FILES}" ]; then
#     ### Start Archeiving ###
#     echo "Files found: $FILES"
#     TIMESTAMP=$(date +%F-%H-%M)
#     ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
#     echo "Zip file name: $ZIP_FILE_NAME"
#     find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"

#     ### Check Archieval Success or not ###
#     if [ -f $ZIP_FILE_NAME ]
#     then
#         echo -e "Archeival ... $G SUCCESS $N"

#         ### Delete if success ###
#         while IFS= read -r filepath
#         do
#             echo "Deleting the file: $filepath"
#             rm -rf $filepath
#             echo "Deleted the file: $filepath"
#         done <<< $FILES
#     else
#         echo "Archieval ... $R FAILURE $N"
#         exit 1
#     fi
# else
#     echo -e "No files to archeive ... $Y SKIPPING $N"
# fi


FILES=$(find $SOURCE_DIR -name ".log" -type f -mtime +14)

count= $1
while [ $count -gt 0 ]
do 
    echo "counting :$count"
    count=$((count-1))
done