#!/bin/sh

 # Script: detect-nonpdftiff
 # created by: Leonardo Macedo
 # contact: macedojleo@gmail.com

user=$1

# User option is null? Defining workdir. 
if [ "$user" == "" ];then
    workdir="/home/1*/*ing" 
else
    workdir="/home/$user/*ing"
fi

# Searching for non .pdf or .tiff files
find $workdir -type f \( -not -name "*.pdf" -a -not -name "*.tiff" \)