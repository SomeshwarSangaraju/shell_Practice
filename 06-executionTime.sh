#!/bin/bash

Start_Time=$(date +%s)
Sleep 10 
End_Time=$(date +%s)
Total_Time=$(($End_Time-$Start_Time))

echo "Total Execution Time: $Total_Time"