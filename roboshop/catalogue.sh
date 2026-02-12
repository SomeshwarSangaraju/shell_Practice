#!/bin/bash

set -euo pipelines

trap "the line no is :$LINE_NO, error in  $BASH_COMMAND ERR"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error:: You need root access for package installation"
    exit 1
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE=$LOGS_FOLDER/$SCRIPT_NAME.log

mkdir -p $LOG_FILE

EXISTS(){
    if [ $? -ne 0 ]; then
        dnf install $1 -y
        VALIDATES $1
    else
        echo "$1 is already exists"
    fi
}

VALIDATES(){
    if [ $? -ne 0 ]; then
        echo "$1 installation is success"
    else
        echo "$1 installation is failed"
    fi
}

dnf module disable nodejs -y
VALIDATES "disabling default nodeJS"

dnf module enable nodejs:20 -y
VALIDATES "enabling 20 nodeJS"

dnf list installed nodejs
EXISTS "nodejs"

# useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop

if ! id roboshop &>/dev/null; then
  useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
  echo "User roboshop created"
else
  echo "User roboshop already exists"
fi


mkdir -p app
VALIDATES "Creating app directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
VALIDATES "downloading catalogue code"

cd /app 
VALIDATES "changing directory"

unzip /tmp/catalogue.zip
VALIDATES "unziping catalogue code"

npm install 
VALIDATES "installing node packages"

cp catalogue.service "/etc/systemd/system/catalogue.service"
VALIDATES "adding catalogue services"

systemctl daemon-reload
VALIDATES "reloading nodeJS server"

systemctl enable catalogue 
VALIDATES "enabling nodeJS"

systemctl start catalogue
VALIDATES "starting nodeJS"

cp mongo.repo "/etc/yum.repos.d/mongo.repo"
VALIDATES "adding mongo repo"

dnf install mongodb-mongosh -y
VALIDATES "installing mongodb"

mongosh --host mongodb </app/db/master-data.js
VALIDATES "loading master data"

# mongosh --host mongodb

