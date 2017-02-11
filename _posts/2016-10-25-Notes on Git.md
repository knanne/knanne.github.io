---
layout: post
categories: [tech]
tags: [git]
sections:
- Getting Started
- Resources
- Workflow
- Sticky Situations
- Notable Commands
---

A quick compilation of notes on Git

<!-- excerpt separator -->

<div class="heading" id="getting_started"></div>

## getting started

- official [documentation](https://git-scm.com/)  
- great easy documenatation from [GitLab](https://docs.gitlab.com/ce/gitlab-basics)  
- [download](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) git  

<div class="heading" id="resources"></div>

## resources

- check out this online [interactive](http://ndpsoftware.com/git-cheatsheet.html) cheat sheet  
- download the [pdf](https://services.github.com/on-demand/downloads/github-git-cheat-sheet.pdf) cheat sheet  
- try GitHub's [educational challenge](https://try.github.io/)
- [GitHub Guides](https://guides.github.com/) has many friendly tutorials

Check install  

```shell
git --version
```

Configure credentials  

```shell
git config --global user.name "Kain Nanne"
git config --global user.email "kain.nanne@gmail.com"
git config --global --list
```

Create SSH key  

```shell
ssh-keygen -t rsa -C "kain.nane@gmail.com"
```

<div class="heading" id="workflow"></div>

## workflow

Clone remote repo  

```shell
git clone HTTPS
```

Since we have cloned a repo, replace REMOTE with `origin` in the folloing commands.

Fetch all or pull remote branch    

```shell
git fetch REMOTE
git pull
```

Create a branch  

```shell
git checkout -b BRANCH
```

Navigate to branch (e.g. master)  

```shell
git checkout BRANCH
```

Now make some changes in the repo, and add those changes  

```shell
git add .
git commit -m "MESSAGE"
```

Check status of changes  

```shell
git status
```

Push changes to repo  

```shell
git push REMOTE BRANCH
```

Merge changes  

```shell
git checkout BRANCH
git merge master
```

<div class="heading" id="sticky_situations"></div>

## sticky situations  

Below are some scenarios that you may find yourself in, and some helpful tips on how to get out.

#### branch is behind master

1. commit changes to branch
2. pull latest master
3. rebase on master
4. resolve conflicts if any
5. force push branch (if already on remote)

#### totally screwed up local repo

Remove untracked changes and revert to last local commit  

```shell
# show to be deleted
git clean -n
# perform deletion
git clean -f
```

Hard reset to state of remote master - *this will remove any untracked changes*  

```shell
git reset --hard
```

<div class="heading" id="notable_commands"></div>

## notable commands

list all committed files  

```shell
git ls-tree --name-only BRANCH
```

list all uncommitted files  

```shell
git ls-files --others
```
