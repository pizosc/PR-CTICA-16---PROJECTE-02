#!/bin/bash
#Comprobar si somos root durante la ejecucion
if [ `id -u` -ne 0 ];
then
   echo "No estas ejecutando como root"
   exit 1
fi

echo "Enter the username to create" $1

echo "Enter the name of the person or application that will be using this account" $2

echo "Enter the lenght of the password to use for the account:"
read password
for p in $(seq 1);
do
	openssl rand -base64 48 | cut -c1-$password
done


echo "Changing password for user" $1

useradd -c $2 $1

if [ $? -ne 0 ]
then
  echo "The id command did not execute successfully."
  exit 1
fi

echo $1:$password | chpasswd

if [ $? -ne 0 ]
then
  echo "The id command did not execute successfully."
  exit 1
fi

passwd -e $1

echo "username: "$1

echo "password: "
openssl rand -base64 48 | cut -c1-$password

echo "host: "hostname
