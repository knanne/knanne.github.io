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
- official [Book on Pro Git](https://git-scm.com/book/)

# Resources

- great easy documentation from [GitLab](https://docs.gitlab.com/ce/gitlab-basics)  
- check out this online [interactive](http://ndpsoftware.com/git-cheatsheet.html) cheat sheet  
- download the [pdf cheat sheet](https://services.github.com/on-demand/downloads/github-git-cheat-sheet.pdf) from Github  
- try GitHub's [educational challenge](https://try.github.io/)
- [GitHub Guides](https://guides.github.com/) has many friendly tutorials
- Atlassian has some [great visual tutorials](https://www.atlassian.com/git/tutorials)

Most open source projects are on GitHub. Checkout [GitHub Explore](https://github.com/explore) to simply "explore" what's out there. For example you can view a list of top projects for related to [government](https://github.com/showcases/government) or [social impact](https://github.com/showcases/social-impact).  

**Advice:** Use [Atom](https://atom.io/) as a text editor for working on git projects! It color codes files (green for added, orange for modified) and allows you to view the fancy side-by-side changelog of a file immediately before checking it in. You can even stage, commit and resolve merge conflicts using only the git-integrated UI.  

Also, check out [GitHub's reference on user autolinks](https://help.github.com/articles/autolinked-references-and-urls/) to things like commits, issues, or users.  

## GitHub Pages

Use [GitHub Pages](https://pages.github.com/) to publish a site for a GitHub account (personal/organization), as well as for hosting GitHub projects like:  

- blog or website using jekyll, at `username.github.io` ([source](https://help.github.com/articles/using-jekyll-as-a-static-site-generator-with-github-pages/))  
- webapp project using the `/docs` folder in project master branch, and find the project at `username.github.io/project` ([source](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/))  

## Contributing to Open Source Projects

Checkout https://opensource.guide/ by GitHub. They have a specific section on [How to submit a contribution](https://opensource.guide/how-to-contribute/#how-to-submit-a-contribution)  

A good accepted standard for making a contribution is:
  1. Fork the repo (using online GitHub GUI)
  2. `git clone <URL>` your forked version to local machine
  3. `git checkout -b <BRANCH>` a new `branch` named after your bug fix or feature
  4. Make your changes, and **make sure you adhere to project standards, and pass any project tests**
  6. `git add .` and `git commit -m "YOUR CHANGES EXPLANATION"`, then `git push -u origin <BRANCH>` to add your new branch to your forked repo's origin
  7. Submit a pull request (using online GitHub GUI) with a description of your changes, referencing the relevant open issues

# Config

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

Easiest way to start is create a repository on [Github](https://github.com) or [GitLab](https://gitlab.com/), then clone it to local.  

```shell
cd projects
git clone <URL>
```

Alternatively, we could initialize a new local directory, and add the repo as remote origin.  

```shell
md repo
cd repo
git init
git remote add origin <URL>
git push -u origin master
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

# Situations  

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

> Do not rebase (public) commits that exist outside your repository - [Pro Git Book](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)

For further notes on this issue, check out [this tutorial by Atlassian](https://www.atlassian.com/git/tutorials/merging-vs-rebasing), which has a great visual walkthrough.  

Otherwise, if you still want to do this...  

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

## A Messy Past

"Prune" is the command for cleaning up the log files or `git` database. It will remove old commits and associated file history which do not exist in the current branches' ancestry.  

> Prune all unreachable objects from the object database - [git website](https://git-scm.com/docs/git-prune)  

You can run `git prune` to simply do this locally.  

However, `git remote prune origin` will remove local history no longer on referenced on remote. You will need to `commit` after this.  

Additionally, adding `--prune` to a `git fetch` will do this local cleaning while fetching new objects.  

Note that none of the `prune` commands delete branches, and there is no magical command from `git` to delete old branches which do not have remote references. Therefore it's better to delete old branches individually with `git branch -d <BRANCH>`.  

# Notable Commands

Create local branch from remote  

```shell
git checkout origin/<BRANCH> -b <BRANCH>
```

Create remote branch from local  

```shell
git push --set-upstream origin <BRANCH>
# or
git push -u origin <BRANCH>
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

Unstage a directory (after staging all with `git add .`)

```shell
git reset -- _dir
```
