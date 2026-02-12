#!/bin/bash

USERID=$(id -u)

# 1. root access to install packages
# 2. if any error occurs stop the process
# 3. idempotency
# 4. check all correct or not

if [ $USERID -ne 0 ]; then
    echo "ERROR:: please run this with root privilages"
    exit 1
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE=$LOGS_FOLDER/$SCRIPT_NAME.log

mkdir -p $LOGS_FOLDER

VALIDATES(){
    if [ $? -ne 0 ];then
        echo "$1 installing if failed" | tee -a "$LOG_FILE"
    else
        echo "$1 installing is success" | tee -a "$LOG_FILE"
    fi
}


cp "mongo.repo" "/etc/yum.repos.d/mongo.repo"
VALIDATES "adding mongo repo"

dnf list installed mysql &>> "$LOG_FILE"
if [ $? -ne 0 ]; then
    dnf install mongodb-org -y &>> "$LOG_FILE"
    VALIDATES mongodb-org 
else
    echo "$1 already exists" | tee -a "$LOG_FILE"
fi

systemctl enable mongod &>> "$LOG_FILE"
VALIDATES "enabling mongod"

systemctl start mongod &>> "$LOG_FILE"
VALIDATES "starting mongod"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATES "adding remote connection"

systemctl restart mongod &>> "$LOG_FILE"
VALIDATES "restarting mongod"
