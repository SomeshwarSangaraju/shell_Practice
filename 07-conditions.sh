#!/bin/bash

number=$1

# less than number or not
if[$number -lt 10]; then
    echo "$number is less than 10"
else
    echo "$number is greater than 1"
fi

# even or odd
if[$(($number%2)) -eq 0]; then
    echo "$number is even"
else
    echo "$number is odd"
fi

# equal to zero or not
if [$(($number))- ne 0]; then
    echo "$number is not equal to zero"
else
    echo "$number is equal to zero"
fi

if[ $? -ne 0]; then
    echo "you need root access to execute"
else
    echo "successfully loggedin"
fi

if[ raining]; then
    echo "umbrella"
else
    echo "sunglasses"
fi