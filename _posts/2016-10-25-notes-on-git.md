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
- [download](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) git  

# Resources

- great easy documentation from [GitLab](https://docs.gitlab.com/ce/gitlab-basics)  
- check out this online [interactive](http://ndpsoftware.com/git-cheatsheet.html) cheat sheet  
- download the [pdf cheat sheet](https://services.github.com/on-demand/downloads/github-git-cheat-sheet.pdf) from Github  
- try GitHub's [educational challenge](https://try.github.io/)
- [GitHub Guides](https://guides.github.com/) has many friendly tutorials

Most open source projects are on GitHub. Checkout [GitHub Explore](https://github.com/explore) to simply "explore" what's out there. For example you can view a list of top projects for related to [government](https://github.com/showcases/government) or [social impact](https://github.com/showcases/social-impact).  

**Advice:** Use [Atom](https://atom.io/) as a text editor for working on git projects! It color codes files (green for added, orange for modified) and allows you to view the fancy side-by-side changelog of a file immediately before checking it in. You can even stage, commit and resolve merge conflicts using only the git-integrated UI.  

Also, check out [GitHub's reference on user autolinks](https://help.github.com/articles/autolinked-references-and-urls/) to things like commits, issues, or users.  

## GitHub Pages

Use [GitHub Pages](https://pages.github.com/) to publish a site for a GitHub account (personal/organization), as well as for hosting GitHub projects like:  

- blog or website using jekyll, at `username.github.io` ([source](https://help.github.com/articles/using-jekyll-as-a-static-site-generator-with-github-pages/))  
- webapp project using the `/docs` folder in project master branch, and find the project at `username.github.io/project` ([source](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/))  

# Config

Easiest way to start is create a repository on [Github](https://github.com) or [GitLab](https://gitlab.com/), then clone it to local.  

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

# Start Project

Easiest way to start is create a repository on [Github](https://github.com), then clone it to local.  

```shell
git clone <URL>
```

Alternatively, we could initialize a new local directory, and add the repo as remote origin.  

```shell
md repo
cd repo
git init
git remote add origin <URL>
```

# Workflow

For the proper workflow, download the GitHub [workflow.pdf](https://guides.github.com/pdfs/githubflow-online.pdf) or view it [online](https://guides.github.com/introduction/flow/). Or, see guide on [Contributing to Open Source](https://guides.github.com/activities/contributing-to-open-source/)  

If you have cloned a repo, replace REMOTE with `origin` in the following commands.  

Fetch all or pull remote branch    

```shell
git fetch <REMOTE>
git pull
```

Create a branch  

```shell
git checkout -b <BRANCH>
```

Now make some changes in the repo, and add (all) those changes  

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

I highly recommend using [Atom](https://atom.io/) while resolving conflicts. It is a text editor made by GitHub and therefor contains very handy options to identify and resolve conflicts with a couple of clicks.  

## Pull with Conflicts

```shell
git checkout feature
git pull
```

In case of conflicts and you want to simply **keep the changes on your local feature branch** (`ours`) of a specific file, and apply them on top of the files being pulled in, do the following:  

```shell
git checkout --ours <FILE>.py
git add .
git commit
git push
```

In case of being stuck in vim after commit, type `:wq`  

## Rebase Local Master (with Conflicts)

```shell
git checkout <FEATURE-BRANCH>
git rebase master
```

This rebase is the same as a pull, however "ours" and "theirs" are switched. In case of conflicts and you want to simply **keep the changes from the new feature branch** (`theirs`) of a specific file, and apply them on top of master, do the following:

```shell
git checkout --theirs <FILE>.ipynb
git checkout --theirs <FILE>.xml
git add .
git rebase --continue
```

> Note that a rebase merge works by replaying each commit from the working branch on top of the <upstream> branch. Because of this, when a merge conflict happens, the side reported as ours is the so-far rebased series, starting with <upstream>, and theirs is the working branch. In other words, the sides are swapped. [Git docs](https://git-scm.com/docs/git-rebase#git-rebase---merge)  

In case you want to force rebase, **resolving all conflicts using the using new feature branch** (`theirs`), do the following.

```shell
git checkout <FEATURE-BRANCH>
git rebase -s recursive -X theirs master
```

## Mistakes Were Made

List previous commits, limit 1  

```shell
git log -n 1
```

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

Create local branch from remote  

```shell
git checkout origin/<BRANCH> -b <BRANCH>
```

List branches  

```shell
git branch --list
```

Navigate to branch  

```shell
git checkout <BRANCH>
```

List all committed files  

```shell
git ls-tree --name-only <BRANCH>
```

List all uncommitted files  

```shell
git ls-files --others
```
