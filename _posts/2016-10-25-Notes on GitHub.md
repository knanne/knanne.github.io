---
categories: [programming]
tags: [github]
---

A compilation of helpful notes on GitHub

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Intro

- Check out [GitHub Guides](https://guides.github.com/)
- GitHub's [guide](https://guides.github.com/activities/hello-world/)

Checkout [GitHub Explore](https://github.com/explore) to simply "explore" what's on GitHub. For example you can view a list of top projects for related to [government](https://github.com/showcases/government) or [social impact](https://github.com/showcases/social-impact).

# Start Project

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

# Proper Workflow

Download the GitHub [workflow.pdf](https://guides.github.com/pdfs/githubflow-online.pdf) or view it [online](https://guides.github.com/introduction/flow/)  

See guide on [Contributing to Open Source](https://guides.github.com/activities/contributing-to-open-source/)  

# GitHub Pages

Use [GitHub Pages](https://pages.github.com/) to publish a site for a GitHub account (personal/organization), as well as for hosting GitHub projects live  

1. Publish a blog or website using jekyll, at `username.github.io` ([source](https://help.github.com/articles/using-jekyll-as-a-static-site-generator-with-github-pages/))

2. Publish a webapp project using the `/docs` folder in project master branch, and find the project at `username.github.io/project` ([source](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/))

# Notable Commands

  - reference an issue using `#` followed by the issue ID  
  - reference a commit simply with the shortened commit hash ID, it will look something like `b1496ae`

[source](https://help.github.com/articles/autolinked-references-and-urls/) in GitHub docs
