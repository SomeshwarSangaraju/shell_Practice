#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR::please run this with root previlages"
    exit 10
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" #/var/log/shell-script/12-logs.log

mkdir -p $LOGS_FOLDER

VALIDATES(){
    if [ $? -ne 0 ]; then
        echo "$1 installation is failed" | tee -a $LOG_FILE
        exit 10
    else
        echo "$1 installation is success" | tee -a $LOG_FILE
    fi
}

for package in "$@"
do 
    dnf list installed $package &>> $LOG_FILE
    if [ $? -ne 0 ]; then
        dnf install $package -y &>> $LOG_FILE
        VALIDATES "$package"
    else
        echo "$package already exist" | tee -a $LOG_FILE
    fi
done