Script 1: create-phoneclient

``` $ create-phoneclient <phonenumber> ```

* Creates a user on the system based on the 10 or 11 digit phone number provided, prompts for password. 
* Passwords should be at a minimum 16 random characters long.
* Home directory for the user should be /home/$USERNAME/.
* Upon user creation there should be 2 additional directory also be created within user's home directory: "incoming" and "outgoing".
* Users that log in should not be able to see any details of other users and should be chrooted to their own folders.
* SSH login should be disabled, users should only be able to do scp. (No Shell).
* Users should have the ability to read and delete but not create files or folders.

Script 2: delete-phoneclient

``` $ delete-phoneclient <phonenumber> ```

* Deletes a user, if there is data in the folder warn and prompt before deleting

Script 3: detect-nonpdftiff

``` $ detect-nonpdftiff <Optional phonenumber>```

* Recursively goes through user folders and shows all files that are not .tiff or .pdf

Script 4: audit-permissions

``` $ audit-permissions <Optional phonenumber>```

* Recursively checks permissions on all user folders and displays any inconsistencies when run. Ideally, folder should have 755 and files should have 644 permissions.

- Installing

1. Create a group called "sftp-only".
  
 Run the following command as root or an equivalent user.

 ``` $ pw groupadd sftp-only ```

2. Setup sftp-server subsystem in sshd_config file

* Comment out the following line on /etc/ssh/sshd_config file.

   #Subsystem      sftp    /usr/libexec/sftp-server

* Add the following lines on /etc/ssh/sshd_config file.

     Subsystem sftp internal-sftp
       Match group sftp-only
       ChrootDirectory /home/%u
       ForceCommand internal-sftp
       AuthorizedKeysFile <put here the authorized_keys path e.g /home/vagrant/.ssh/authorized_keys>

* Restart the SSHD process

  ``` $ service sshd restart ```
