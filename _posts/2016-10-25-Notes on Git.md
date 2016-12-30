---
layout: post
categories: [tech]
tags: [git, tutorial]
---

Notes on Git.

<!--excerpt separator -->

# Intro to Git

- great easy documenatation from [GitLab](https://docs.gitlab.com/ce/gitlab-basics)  
- [download](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) git for windows  

#### check install
```
git --version
```

#### config credentials  
```
git config --global user.name "Kain Nanne"
git config --global user.email "kain.nanne@gmail.com"
git config --global --list
```

#### create SSH key  
```
ssh-keygen -t rsa -C "kain.nane@gmail.com"
```

## Getting Started  

#### clone remote repo  
```
git clone HTTPS
```

Since we have cloned repo, replace REMOTE with `origin` in the folloing commands.

#### fetch all, pull branch  
```
git fetch REMOTE
git pull
```

#### navigate to branch (e.g. master)  
```
git checkout BRANCH
```

#### create a branch  
```
git checkout -b BRANCH
```

#### check status of changes  
```
git status
```

#### add changes  
```
git add .
git commit -m "MESSAGE"
```

#### push changes to repo  
```
git push REMOTE BRANCH
```

#### merge changes  
```
git checkout BRANCH
git merge master
```

# Example Situations  

## branch is behind master

1. commit changes to branch
2. pull latest master
3. rebase on master
4. resolve conflicts if any
5. force push branch (if already on remote)

## totally screwed up local repo

1. reset hard to remote master