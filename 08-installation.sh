#!/bin/bash

USER=$(id -u)

if [$USER -ne 0]; then
    echo "Install with root access"
fi