---
layout: post
image: /assets/img/posts/github.png
categories: [tech]
tags: [github, tutorial]
---

Notes on GitHub.

<!--excerpt separator -->

## Intro to Github

- Check out [GitHub Guides](https://guides.github.com/)
- GitHub's [guide](https://guides.github.com/activities/hello-world/)

## Getting Started

Easiest way to start is create a repository on [Github](https://github.com), then clone it to local.
```shell 
git clone https://github.com/username/repo
```

Alternatively, we could initialize a new local directory, and add the repo as remote origin.
```shell
md repo
cd repo
git init
git remote add origin https://github.com/user/repo.git
```

Make some changes, and push all to master.
```shell
echo "Hello World" > index.html
git add --all
git commit -m "initial commit"
git push -u origin master
```

### proper workflow

Download the github [workflow.pdf](https://guides.github.com/pdfs/githubflow-online.pdf) or view it [online](https://guides.github.com/introduction/flow/)

1. create new branch
2. make and commit changes to branch
3. create a [pull request](https://help.github.com/articles/creating-a-pull-request/)
4. merge pull request with master