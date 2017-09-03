---
categories: [programming]
tags: [git]
---

A quick compilation of notes on Git

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Getting Started

- official [Git documentation](https://git-scm.com/)  
- great easy documentation from [GitLab](https://docs.gitlab.com/ce/gitlab-basics)  
- [download](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) git  

# Resources

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

# Workflow

Clone remote repo  

```shell
git clone HTTPS
```

Since we have cloned a repo, replace REMOTE with `origin` in the folloing commands.

Fetch all or pull remote branch    

```shell
git fetch <REMOTE>
git pull
```

Create a branch  

```shell
git checkout -b <BRANCH>
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
git push
```

Merge changes  

```shell
git checkout <BRANCH>
git merge master
```

# Sticky Situations  

Below are some scenarios that you may find yourself in, and some helpful tips on how to get out.

## Behind Master

1. commit changes to branch
2. pull latest master
3. rebase on master
4. resolve conflicts if any
5. force push branch (if already on remote)

I highly recommend using [Atom](https://atom.io/) while resolving conflicts. It is a text editor made by GitHub and therefor contains very handy options to indentify and resolve conflicts with a couple of clicks.  

## Pull with Conflicts

```shell
git checkout feature
git rebase master
```

At this point you may have merge conflicts, which could even contain random files like jupyter notebooks that are difficult to manually navigate for resolving conflicts. If you want to simply **keep the changes on your local feature branch** of a specific file, and apply them on top of the files being pulled in, do the following:  

```shell
git checkout --ours <FILE>.py
git add .
git commit
git push
```

In case of being stuck in vim after commit, type `:wq`  

## Rebase with Conflicts

This resolve is the same as a pull merge, however "ours" and "theirs" are switched.  

```shell
git checkout feature
git rebase master
```

At the point of existing merge conflicts and you don't want to manually resolve, do the following to **keep the changes from the new feature branch** of a specific file, and apply them on top of master:  

```shell
git checkout --theirs <FILE>.ipynb
git checkout --theirs <FILE>.xml
git add .
git rebase --continue
```

> Note that a rebase merge works by replaying each commit from the working branch on top of the <upstream> branch. Because of this, when a merge conflict happens, the side reported as ours is the so-far rebased series, starting with <upstream>, and theirs is the working branch. In other words, the sides are swapped. [Git docs](https://git-scm.com/docs/git-rebase#git-rebase---merge)  

## Mistakes Were Made

Reset current HEAD and index to last commit

```shell
git reset --hard
```

Remove untracked files from the working tree  

```shell
# show to be deleted
git clean -n
# perform deletion
git clean -f
```

# Notable Commands

List branches  

```shell
git branch --list
```

Navigate to branch  

```shell
git checkout <BRANCH>
```

List previous commits, limit 1  

```shell
git log -n 1
```

List all committed files  

```shell
git ls-tree --name-only <BRANCH>
```

List all uncommitted files  

```shell
git ls-files --others
```
