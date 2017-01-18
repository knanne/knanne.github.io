---
layout: post
categories: [tech]
tags: [git, tutorial]
---

A quick compilation of notes on git.

<!--excerpt separator -->

## getting started

- official [documentation](https://git-scm.com/)  
- great easy documenatation from [GitLab](https://docs.gitlab.com/ce/gitlab-basics)  
- [download](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) git  

## resources

- check out this online [interactive](http://ndpsoftware.com/git-cheatsheet.html) cheat sheet  
- download the [pdf](https://services.github.com/on-demand/downloads/github-git-cheat-sheet.pdf) cheat sheet  
- try GitHub's [educational challenge](https://try.github.io/)
- [GitHub Guides](https://guides.github.com/) has many friendly tutorials

###### check install  
```shell
git --version
```

###### config credentials  
```shell
git config --global user.name "Kain Nanne"
git config --global user.email "kain.nanne@gmail.com"
git config --global --list
```

###### create SSH key  
```shell
ssh-keygen -t rsa -C "kain.nane@gmail.com"
```

## start working

###### clone remote repo  
```shell
git clone HTTPS
```

Since we have cloned a repo, replace REMOTE with `origin` in the folloing commands.

###### fetch all, pull branch  
```shell
git fetch REMOTE
git pull
```

###### navigate to branch (e.g. master)  
```shell
git checkout BRANCH
```

###### create a branch  
```shell
git checkout -b BRANCH
```

###### check status of changes  
```shell
git status
```

###### add changes  
```shell
git add .
git commit -m "MESSAGE"
```

###### push changes to repo  
```shell
git push REMOTE BRANCH
```

###### merge changes  
```shell
git checkout BRANCH
git merge master
```

## example situations  

#### branch is behind master

1. commit changes to branch
2. pull latest master
3. rebase on master
4. resolve conflicts if any
5. force push branch (if already on remote)

#### totally screwed up local repo

###### remove untracked changes
```shell
# show to be deleted
git clean -n
# perform deletion
git clean -f
```

###### hard reset to remote master **this will remove any untracked changes*
```shell
git reset --hard
```

