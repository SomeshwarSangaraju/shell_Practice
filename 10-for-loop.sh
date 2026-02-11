#!/bin/bash

USER=$(id -u)

if [ $USER -ne 0 ]; then
    echo "Error:: please run this with root access"
    exit 1
fi

VALIDATES(){
    if [ $? -ne 0 ]; then
        echo "$1 installation is failed"
        exit 1
    else
        echo "$1 installation is success"
    fi
}

for pkg in "$@"
do 
    dnf list installed $pkg 
    if [ $? -ne 0 ]; then
        dnf install $pkg -y
        VALIDATES "$pkg"
    else
        echo "$pkg already exist"
    fi
done