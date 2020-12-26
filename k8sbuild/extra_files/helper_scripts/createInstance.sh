#!/bin/bash

#server name
server="client3"
serverip="185.26.148.88"
#client name
client="21244"
#client port
port="3032"

ansible-playbook -i ../../hosts ../../clientnginxcreation.yml -e "client_number=$client" -e "pm2_port=$port" -e "client_ip=$serverip"
ansible-playbook -i ../../hosts ../../clientpm2creation.yml -e "client_number=$client" -e "port=$port" -e "host=$server"


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
