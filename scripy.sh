#!/bin/bash

NEWDATE= TZ=GMT+12 date +%Y-%m-%d" "%H:%M:%S


data=$( aws ec2 describe-instances --query 'Reservations[*].Instances[?LaunchTime>=NEWDATE].[InstanceId]' --output text | sort -n)
 
printf "%s\n" "${data[@]}" > file.txt

for id in $(cat file.txt)
do
aws ec2 terminate-instances --instance-ids $id   
done


