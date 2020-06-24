#!/bin/sh

# Script: audit-permissions
# created by: Leonardo Macedo
# contact: macedojleo@gmail.com

user=$1

# Setting default permissions 
filePermission=644
dirPermission=755

# User option is null? Defining workdir
if [ "$user" == "" ];then
    workdir="/home/1*/*ing"
    msg="ALL users"
else
    workdir="/home/$user/*ing"
    msg="$user"
fi

# Searching for permissions inconsistences

echo "File permission inconsintence ( $msg )"
find $workdir -type f \( -not -perm $filePermission \) | xargs stat -F
echo ""
echo "Folder permission inconsistence ( $msg )"
find $workdir -type d \( -not -perm $dirPermission \) | xargs stat -F
echo ""