# SSH Server

This is a simple alpine based SSHD server

  * A user is dedicated for SSH connection (named sshuser)
  * The /data directory is dedicated to transfer files (The way I use it)
  * Every files older than 5min will be deleted
  * Listening on port 22
  * Authentication can be done by SSH keys or password
  
You can use it inside kubernetes.

## Security features:

* The user root's password is un-assigned. 
* The container expects a ENV variable named "AUTHORIZED_KEYS" containing your SSH public key in it. If this ENV var is found empty, this container does not start. This prevents it becoming an open-(ssh)-relay. 

So simply pass your ssh public key as env var AUTHORIZED_KEYS to the container at run time, and you are good to go. You can actually pass multiple SSH public keys by putting them in one file, and then letting the entire file load as a string in this ENV variable. For example:

```
AUTHORIZED_KEYS="$(cat .ssh/my_many_ssh_public_keys_in_one_file.txt)"
```

# Deployment

In the deploy folder, there are:

* a docker folder with a docker-compose file to launch it
* a k8s folder with the manifests