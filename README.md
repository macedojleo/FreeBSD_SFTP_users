Script 1: create-phoneclient phonenumber
* Creates a user on the system based on the 10 or 11 digit phone number provided, prompts for password. 
* Passwords should be at a minimum 16 random characters long.
* Home directory for the user should be /home/$USERNAME/.
* Upon user creation there should be 2 additional directory also be created within user's home directory: "incoming" and "outgoing".
* Users that log in should not be able to see any details of other users and should be chrooted to their own folders.
* SSH login should be disabled, users should only be able to do scp. (No Shell).
* Users should have the ability to read and delete but not create files or folders.

Script 2: delete-phoneclient phonenumber
* Deletes a user, if there is data in the folder warn and prompt before deleting

Script 3: detect-nonpdftiff files
* Recursively goes through user folders and shows all files that are not .tiff or .pdf

Script 4: audit-permissions
* Recursively checks permissions on all user folders and displays any inconsistencies when run. Ideally, folder should have 755 and files should have 644 permissions.
