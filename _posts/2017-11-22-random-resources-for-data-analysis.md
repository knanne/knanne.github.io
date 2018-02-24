---
categories: [data analysis]
tags: []
---

Random notes, links, commands or snippets of code related to data analysis and the like.

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# GitHub

Download a single file from GitHub using the curl and a hidden, direct path.  

```shell
curl https://raw.githubusercontent.com/username/project/branch/file > outfile
```

# SFTP

Secure File Transfer Protocol over SSH. DigitalOcean has a [good post](ttps://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server) to start with.

Here are the necessary basics for connecting and transferring files.  

```shell
sftp username@remote_hostname_or_IP

get remoteFile localFile

put localFile
```
