#! /bin/sh

# Script: scp_files.sh
# Created by: Leonardo Macedo
# Contact: macedojleo@gmail.com

#remoteServer="Put here the remote server address"
remoteServer="host2"
homedir="/home"
users=`ls $homedir | egrep '^[0-9]{10}$'`
warningMsg="/tmp/scp_file_error"

scpFunction() {

 if [ -d $1 ] && ssh -n -o LogLevel=ERROR $3 '[ -d '$2' ]'; then
    
    log "INFO" "Fetching .pdf and .tiff files from $3:$2 to localhost:$1"
    scp -o LogLevel=ERROR $3:$2/*.pdf  $3:$2/*.tiff $1 2> $warningMsg
    warning $? $warningMsg

    log "INFO" "Changing the ownership of these files to $4 user" 
    chown $4 $1/*.pdf $1/*.tiff 2> $warningMsg
    warning $? $warningMsg
 else
    log "INFO" "Local and remote folders does not match"
 fi

}

warning() {

    msg=`cat $2 | xargs`
    if [ ! $1 -eq 0 ]; then
    log "WARNING" "$msg"
    fi
}

log() {

    type=$1
    message=$2
    ts=`date +%Y%m%d-%H:%M:%S`

    echo "$type | $ts | $message"
}

ssh -q $remoteServer exit
if [ $? -ne 0 ]; then
  log "ERROR" "Could not resolve the hostname: $remoteServer"
  exit 1;
fi

if [ -z "${users}" ]; then 
	 log "ERROR" "No users found!"
	 exit 1;
fi

echo "$users" | while IFS= read -r user
do

 log "START" "Found user: $user"

 remoteIncoming="/mnt/incomingFax/$user" # Remote Incoming path
 remoteOutgoing="/mnt/fax/$user"         # Remote Outgoing path
 localIncoming="/home/$user/incoming"    # Local Incoming path 
 localOutgoing="/home/$user/outgoing"    # Local Outgoing path
 
 scpFunction $localIncoming $remoteIncoming $remoteServer $user
 scpFunction $localOutgoing $remoteOutgoing $remoteServer $user

done

log "INFO" "Done!"