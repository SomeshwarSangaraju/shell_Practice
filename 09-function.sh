#!/bin/bash

USER=$(id -u)

if [$USER -ne 0]; then
    echo "ERROR:: Please run this with root access"
    exit 1
fi

VALIDATES(){
    if [ $? -ne 0]; then
        echo "$1 installation is success"
    else
        echo "$1 installation is failed"
    fi
}
dnf install mysql -y
VALIDATES mysql


dnf install nginx -y
VALIDATES nginx

dnf install mongodb -y
VALIDATES mongodb