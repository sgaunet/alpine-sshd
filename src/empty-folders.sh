#!/bin/sh

if [ "${DELETEOLDERFILESINMIN}" -gt "0" ]
then
    while [ "" = "" ]
    do
        find /data -type f -mmin +${DELETEOLDERFILESINMIN} -exec rm {} \;
        sleep 55
    done
else
    echo "INFO: No PURGE"
fi