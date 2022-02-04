#!/bin/sh

while [ "" = "" ]
do
    find /data -type f -mmin +5 -exec rm {} \;
    sleep 30
done
