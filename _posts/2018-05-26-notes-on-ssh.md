---
categories: [data engineering]
tags: [ssh]
---

Random notes on using SSH

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# SSH

> ssh (SSH client) is a program for logging into a remote machine and for executing commands on a remote machine. - [website](https://man.openbsd.org/ssh.1)

# Keys

Most implementations of SSH connection will use the secure route of authentication through keys. Meaning authentication is done by comparing the transmission of an encrypted string across hosts. A private-public key pair is first generated on the local machine wishing to connect to the remote. The public key is then shared with the remote machine you wish to connect with, while the private key is never shared. Encryption is done on the remote machine with the public key, and decryption is done with the private key living only on the connecting machine before sending the decrypted message back for verification.  

Typically when doing this procedure for services like GitHub or GitLab, it is best to simply follow there docs to ensure your profile is configured correctly to their needs.  

SSH keys are typically stored in the root or user's directory in a folder called `~/.ssh/`.  

To quickly generate a key pair to be used for a specific task, do the following. Maybe you need to generate it for two remote servers needing to connect, or another user.  

```shell
ssh-keygen -f <KEYFILE> -C <USERNAME>
```

## Change Password

In case you created a keyfile with a password, and need to change or remove it, use the following command. To remove the password just hit enter when prompted for the new one.  

```shell
ssh-keygen -p -f <KEYFILE>
```

# Connecting

```shell
ssh -i <KEYFILE> <USERNAME>@<REMOTEHOST>
```

# Copy

# Execute Command

# Execute Local File

# Code Snippets

# Example of Python Workflow

### Move Requirements Over

```shell
scp ssh -i <KEYFILE> path\to\local\requirements.txt <USERNAME>@<REMOTEHOST>:\path\to\remote\requirements.txt
```

### Install Requirements

```shell
ssh -i <KEYFILE> <USERNAME>@<REMOTEHOST "pip install -r requirements.txt"
```

### Execute Local Python File

```shell
cat path\to\local\file.py | ssh -i <KEYFILE> <USERNAME>@<REMOTEHOST> python - > path\to\local\log.txt
```

# SFTP

Secure File Transfer Protocol over SSH. DigitalOcean has a [good post](ttps://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server) to start with.  

Here are the necessary basics for connecting and transferring files.  

```shell
sftp username@remote_hostname_or_IP

get remoteFile localFile

put localFile
```
