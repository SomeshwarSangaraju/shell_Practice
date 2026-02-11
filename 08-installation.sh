#!/bin/bash

USER=$(id -u)

echo "$User"

if [$USER -ne 0]; then
    echo "Install with root access"
    exit 1
fi

dnf install mysql -y

if [ $? -ne 0]; then
    echo "mysql installation failed"
    exit 1
else
    echo "mysql installation success"
fi