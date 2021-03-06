#!/bin/sh

# Script: delete-phoneclient 
# Created by: Leonardo Macedo
# Contact: macedojleo@gmail.com

 user=$1
 userdir="/home/$user"

 # USERNAME format 
 if ! echo $user | egrep -q '^1[0-9]{9}$'; then 
	 echo "ERROR! Invalid username format. Use 1XXXXXXXXX"
	 exit 1;
 fi
 
 # USER exists? 
 if ! id -u "$user"; then
	   echo "The user $user does not exists"
	   exit 0;
 else
      # HOMEDIR exists?
      if [ ! -d  $userdir ]; then
		echo "ERROR! Directory $userdir does not exists."
		exit 1;
      fi

	 # Input/Output directories are empty?
	 countUsrFiles=`find $userdir/*ing/ -type f \( -name "*.pdf" -o -name "*.tiff" \) | wc -l`

      if [ $countUsrFiles -ne 0 ]; then
        
		read -p "The user directory $userdir is not empty. Are you sure you want to continue [yes|no]?" delete
        
		case $delete in
		no)
		    echo "bye"
			exit 0;
			;;
		yes)
			pw userdel -n $user -r && echo "User $user has been removed." || echo "Not removed."
			exit 0;
			;;
        *)
			echo "Invalid option $delete"
			exit 1;
			;;
        esac
      fi
	fi
 
 pw userdel -n $user -r && echo "User $user has been removed." || echo "Not removed."
 exit 0;