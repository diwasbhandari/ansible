Ansible Scripts required to build the Connect cloud using Kubernetes

To run the ansible scripts, a user "cansible" is required with preshared key from the Ansible master node

From the shell, add user with 
adduser cansible
Update the repos
sudo apt update
Install sudo to allow elevated privileges to the new user
apt install sudo
nano /etc/sudoers
add cansible as the privileged user with the line "cansible ALL=(ALL) NOPASSWD: ALL" just below root ( should be on line 20 of the file ). This allows the Cansible user to act with elevated privileges without prompting a password and can be changed to reduce “power” on the ansible user .

Make sure to copy the rsa key from the cansible server to the required target host.

ssh-keygen ( if you dont have a key already ) and then copy with 
ssh-copy-id -i /path/of/the/id/file cansible@192.168.0.50

if you have a mix estate with AWS, use pem keys for all hosts; to exctract the pub key from the AWS provided pem use
ssh-keygen -y -f /home/cansible/.ssh/connectAnsible.pem
copy the outcome to the host authorized keys file ( .ssh/authorized_keys )


The playbook is run fromt he ansible server from the cansible user as below:

ansible-playbook -i hosts addUFWrules.yml --private-key=/home/cansible/.ssh/connectAnsible.pem

Execute the files in the followign order:

grantAccess ( if you have a preshare key with root access you can use this to create users instead of the above processes )
serverBaseCreation
mongodbCreation
addUFWrules
nginxServerCreation
fileserverCreation
k8sMasterCreation
k8sWorkerCreation
k8sMasterConfig
k8sWorkerConfig

P.s. for the purpose of deleting instances db, an additional roel is required for the mongodb user ( connectUser ); run th efollowign from inside the admin db in mongo:
db.grantRolesToUser("connectUser",[{role: "dbAdminAnyDatabase", db: "admin" }])

On each worker make sure to set the relevant region label using "kubectl label nodes k8sworker02 location=uk" or "kubectl label nodes ausk8sworker02 location=aus"

To add new workers create a host file with the new workers and run the grantAccess followed by the serverBaseCreation; using the full list of hosts, run the addUFWrules. On completion, using the new host file, run k8sworkercreation and k8sworkerconfig.



