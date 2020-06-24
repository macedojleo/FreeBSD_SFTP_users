#!/bin/sh

# Script: create-phoneclient 
# Created by: Leonardo Macedo
# Contact: macedojleo@gmail.com

 user=$1
 userdir="/home/$user"

 # USER format 
 if ! echo $user | egrep -q '^1[0-9]{10}$'; then 
	 echo "ERROR! Invalid username format. Try 1XXXXXXXXXX"
	 exit 1;
 fi

 read -p "Type Password for $user: " pass

 # PASSWORD format
 if ! echo $pass | egrep -q '^[a-zA-Z0-9,@,#,\$,%,&,!]{16,}$'; then
        echo "ERROR! Invalid Password format. Please enter a password at least 16 characters length"
        exit 1;
 fi

 # USER exists? 
 if id -u "$user" >/dev/null 2>&1; then
	   echo "ERROR! The user $user already exists."
	   exit 0;
 else
      # sftp-only group exists?
	  echo "$pass" | pw useradd -h 0 -n $user -m -G sftp-only -d $userdir -s /sbin/nologin && echo "User $user has been created" || echo "Error"

 # HOMEDIR was created? 
 	if [ ! -d $userdir ]; then
	  echo "ERROR! Couldn't create the dir $userdir."
	  exit 1
    fi

	mkdir -p $userdir/incoming && echo "OK! Directory $userdir/incoming has been created"
	chown $user $userdir/incoming

	mkdir -p $userdir/outgoing && echo "OK! Directory $userdir/outgoing has been created"
	chown $user $userdir/outgoing

	chown root:$user $userdir
	chmod -R 755 $userdir
 fi