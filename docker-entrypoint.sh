#!/bin/sh

if [ -z "${AUTHORIZED_KEYS}" ]; then
  echo "ERROR: Need your ssh public key as AUTHORIZED_KEYS env variable. Abnormal exit ..."
  exit 1
fi

mkdir /home/sshuser/.ssh
chmod 0700 /home/sshuser/.ssh 

echo "INFO: Populating /root/.ssh/authorized_keys with the value from AUTHORIZED_KEYS env variable ..."
echo "${AUTHORIZED_KEYS}" > /home/sshuser/.ssh/authorized_keys
chown -R sshuser:ssh_group /home/sshuser/.ssh 
chmod 600 /home/sshuser/.ssh/authorized_keys

for folder in $DATA_FOLDERS
do
  echo "INFO: Create /data/$folder"
  mkdir -p /data/$folder
  chown sshuser:ssh_group /data/$folder
done

if [ ! -z "$SSHUSER_PASSWORD" ]
then
  echo -e "$SSHUSER_PASSWORD\n$SSHUSER_PASSWORD" | passwd sshuser
else
  sed -i s/^#PasswordAuthentication\ yes/PasswordAuthentication\ no/ /etc/ssh/sshd_config
fi

exec "$@"
