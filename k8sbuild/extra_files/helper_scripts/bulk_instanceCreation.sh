#!/bin/bash

#array of instance names
arrayInstances=()
#array of instance ports
arrayPorts=()

#server name
server="client7"
serverip="101.0.122.10"

counta=0;
for i in "${arrayInstances[@]}"
do
  echo "--------------------------"
  echo "creating host: $i with port: ${arrayPorts[$counta]} in nginx"
  echo "count is: $counta"
  ansible-playbook -i ../../hosts ../../clientnginxcreation.yml -e "client_number=$i" -e "pm2_port=${arrayPorts[$counta]}" -e "client_ip=$serverip"
  echo "now creating pm2 for host: $i with port: ${arrayPorts[$counta]}"
  ansible-playbook -i ../../hosts ../../clientpm2creation.yml -e "client_number=$i" -e "port=${arrayPorts[$counta]}" -e "host=$server"
  echo "completed host: $i port: ${arrayPorts[$counta]}"
  counta=$((counta+1))
done

#[client1]
#185.26.148.83
#[client2]
#185.26.148.87
#[client3]
#185.26.148.88
#[client4]
#185.26.148.89
#[client5]
#185.26.148.74
#[client6]
#185.26.148.85
#[client7]
#101.0.122.10
