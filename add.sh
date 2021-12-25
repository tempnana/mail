#!/bin/bash
###add domain and user
user=some_user_name
password=some_user_password
cd james-server-app-3.1.0/bin
cat /root/add.txt | while read domain
do
sh james-cli.sh -h localhost -p 9999 AddDomain $domain
sleep 1
sh james-cli.sh -h localhost -p 9999 AddUser $user@$domain $password
done
###list domain and user
# sh james-cli.sh -h localhost -p 9999 ListDomains
# sh james-cli.sh -h localhost -p 9999 ListUsers
