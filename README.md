### Scripts

Script 1: create-phoneclient

``` $ create-phoneclient.sh <phonenumber> ```

* It will create an user based on 10 or 11 digit phone number and prompt for password. 
* The passwords should be at a minimum 16 random characters long.
* The home dir should be /home/$USERNAME/.
* Upon user creation there should be 2 additional directory also be created within user's home directory: "incoming" and "outgoing".
* Users that log in should not be able to see any details of other users and should be chrooted to their own folders.
* SSH login should be disabled, users should only be able to do scp. (No Shell).
* Users should have the ability to read and delete but not create files or folders.

Script 2: delete-phoneclient

``` $ delete-phoneclient.sh <phonenumber> ```

* It will delete the user. Warn and prompt before deleting

Script 3: detect-nonpdftiff

``` $ detect-nonpdftiff.sh <Optional phonenumber>```

* Recursively goes through user folders and list all files aren`t .tiff or .pdf 

Script 4: audit-permissions

``` $ audit-permissions.sh <Optional phonenumber>```

* Recursively check all users folders permissions and display any inconsistencies.

Script 5: scp_files

``` $ scp_files.sh ```

* Fetch all .pdf and .tiff files from remote server to the respective input and output folders into the local server. 

### Setting up the environment

1. Create "sftp-only" group.
  
Run as root or equivalent provilege.

 ``` $ pw groupadd sftp-only ```

2. Configure the sftp-server subsystem.

* Comment this line in /etc/ssh/sshd_config file.

   #Subsystem      sftp    /usr/libexec/sftp-server

* Add these lines in the same file.

     Subsystem sftp internal-sftp
       Match group sftp-only
       ChrootDirectory /home/%u
       ForceCommand internal-sftp
       AuthorizedKeysFile <put here the authorized_keys path e.g /home/vagrant/.ssh/authorized_keys>

3. Restart the SSHD process

  ``` $ service sshd restart ```
