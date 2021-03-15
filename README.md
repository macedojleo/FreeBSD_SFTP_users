### Scripts

Script 1: create-phoneclient

``` $ create-phoneclient.sh <phonenumber> ```

* It will create an user based on their phone number (10 or 11 digit); Prompt for password. 
* Passwords should be 16 random characters long at least.
* Home dir should /home/$USERNAME/.
* 2 additional directory should be create in the user's home directory: "incoming" and "outgoing".
* Users shouldn't be able to see folders or files which aren't owner (chrooted).
* SSH login should be disabled, only SFTP should be allowed. (No Shell).
* Users should have the ability to read and delete but not create files or folders.

#### Script 2: delete-phoneclient

``` $ delete-phoneclient.sh <phonenumber> ```

* It will delete the user; prompt before deleting.

#### Script 3: detect-nonpdftiff

``` $ detect-nonpdftiff.sh <Optional phonenumber>```

* Recursively goes through user folders listing all files that aren't .tiff or .pdf extensions. 

#### Script 4: audit-permissions

``` $ audit-permissions.sh <Optional phonenumber>```

* Recursively check all users folders permissions and display any inconsistencies.

#### Script 5: scp_files

``` $ scp_files.sh ```

* Fetch all .pdf and .tiff files from remote server to its respective input and output folders. 

### Setting up

#### 1. Create "sftp-only" group.
  
Run as root or equivalent privileges.

 ``` # pw groupadd sftp-only ```

#### 2. Configure the sftp-server subsystem.

Edit the file **/etc/ssh/sshd_config**:

``` $ vi /etc/ssh/sshd_config ```

* Comment that line:
```
   *#Subsystem      sftp    /usr/libexec/sftp-server*
```

* Add those lines.


```
     *Subsystem sftp internal-sftp*
       *Match group sftp-only*
       *ChrootDirectory /home/%u*
       *ForceCommand internal-sftp*
       *AuthorizedKeysFile <put here the authorized_keys path e.g /home/vagrant/.ssh/authorized_keys>*
```

#### 3. Restart SSHD process

  ``` $ service sshd restart ```
