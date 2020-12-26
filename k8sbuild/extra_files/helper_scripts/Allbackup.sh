#!/bin/bash


#array of hosts names
arrayServers=(admin client1 client2 client3 client4 client5 client6 client7)

datevar=$(date +%N)
for i in "${arrayServers[@]}"
do
  echo "---------- Server ${i} --------------"
  fname="$datevar$i"
  ansible-playbook -i ../../hosts mongopm2Backup.yml -e "host=$i" -e "folder_name=$fname"
done

file="filesever"
filesname="$datevar$file"
ansible-playbook -i ../../hosts fileserverBackup.yml -e "host=fileserver" -e "folder_name=$filesname"

file="nginx"
nginxname="$datevar$file"
ansible-playbook -i ../../hosts nginxBackup.yml -e "host=nginx" -e "folder_name=$nginxname"
