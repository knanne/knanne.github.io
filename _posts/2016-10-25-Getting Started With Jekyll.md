---
layout: post
image: /assets/img/posts/jekyll.png
categories: [tech]
tags: [jekyll, tutorial]
---

Notes on using Jekyll for creating a website on GitHub pages.

<!--excerpt separator -->

## Intro to Jekyll

- jekyll [website](https://jekyllrb.com/)
- [github pages](https://pages.github.com/)

## Getting Started

**currently windows is a hassle to install on**

1. install chocolatory
2. install ruby 2.2.4, or downgrade
3. cofigure ruby installation
4. install gem github-pages

source: [jekyllrb](https://jekyllrb.com/docs/windows/#installation),
[jwillmer](https://jwillmer.de/blog/tutorial/how-to-install-jekyll-and-pages-gem-on-windows-10-x46#install-github-gem)

### init blog
```shell
>>> jekyll new myBlog
```

This will install github-pages default files, including the [minima](https://github.com/jekyll/minima) theme.

### serve blog
```shell
>>> jekyll serve
```

find the app hosted at [http://localhost:4000/](http://127.0.0.1:4000)

add `-watch` for auto updates, **currently not supported in windows**

## Customization

### theme

To remove the default theme, remove the `gem 'minima'` in Gemfile, and remove `theme='minima'` settings in _config.yml.