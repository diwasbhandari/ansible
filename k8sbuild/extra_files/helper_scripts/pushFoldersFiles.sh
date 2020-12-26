#!/bin/bash


#array of hosts names
arrayServers=(timeManagement)

sourceFname=""

destFname=""

datevar=$(date +%N)
for i in "${arrayServers[@]}"
do
  echo "---------- Server ${i} --------------"
  fname="$datevar$i"
  ansible-playbook -i ../../hosts filepush.yml -e "host=$i" -e "folder_name=$fname"
done
