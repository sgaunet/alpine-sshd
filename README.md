# SSH Server

This is a simple alpine based SSHD server

  * A user is dedicated for SSH connection (named sshuser)
  * The /data directory is dedicated to transfer files (The way I use it)
  * Every files older than 5min will be deleted
  * Listening on port 22
  * It allows only key based access for the sshuser
  
You can use it to test containers inside kubernetes.

## Security features:

* The user root's password is un-assigned. 
* The only authentication enabled over ssh is key based authentication. Repeat: Password based authentication is disabled.
* The container expects a ENV variable named "AUTHORIZED_KEYS" containing your SSH public key in it. If this ENV var is found empty, this container does not start. This prevents it becoming an open-(ssh)-relay. 

So simply pass your ssh public key as env var AUTHORIZED_KEYS to the container at run time, and you are good to go. You can actually pass multiple SSH public keys by putting them in one file, and then letting the entire file load as a string in this ENV variable. For example:

```
AUTHORIZED_KEYS="$(cat .ssh/my_many_ssh_public_keys_in_one_file.txt)"
```

