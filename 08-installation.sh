#!/bin/bash

USER=$(id -u)

if [$USER -ne 0]; then
    echo "Install with root access"
    exit 1
fi


dnf list installed mysql -y

if [ $? -ne 0]; then
    dnf install mysql -y
else
    echo "already exist"
fi