#!/bin/bash

#client name
client="client2"

#client array
arrayInstances=()

#loop
counta=0;
for i in "${arrayInstances[@]}"
do
  echo "--------------------------"
  echo "starting host: $i"
  echo "count is: $counta"
  ansible-playbook -i ../../hosts pm2startExisting.yml -e "client_number=$i" -e "host=$client"
  counta=$((counta+1))
done
