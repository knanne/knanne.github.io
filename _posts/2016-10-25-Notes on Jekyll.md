---
layout: post  
categories: [tech]  
tags: [jekyll, tutorial]  
---

Notes on using Jekyll for creating a website on GitHub pages.  

<!--excerpt separator -->

## Intro to Jekyll

- [jekyll website](https://jekyllrb.com/)  
- [github pages](https://pages.github.com/)  

## Getting Started

jekyll provides specific [install instructions](http://jekyll.tips/jekyll-casts/install-jekyll-on-windows/) for windows, but for current github pages integration, use the following

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

### harnessing jekyll engine  

- refer to jekyll [cheat sheet](http://jekyll.tips/jekyll-cheat-sheet/)  

#### using liquid  

> "Liquid is an open-source template language created by Shopify and written in Ruby."

- ref liquid [website](https://shopify.github.io/liquid/)  

get recent posts and print title, dates and excerpts  

```html
{% for post in site.posts limit : 3 %}
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
    <p class="text-muted">{{ post.date | date: "%b %-d, %Y" }}</p>
    <p>{{ post.excerpt | strip_html }}</p>
{% endfor %}
```

get all posts organized by category  

```html
{% for category in site.categories %}
    <h3>{{ category | first }}</h3>
    {% for posts in category %}
        {% for post in posts %}
            <a href="{{ post.url }}">{{ post.title }}</a>
            <a class="text-muted" style="font-size: 12px">{{ post.date | date: "%b %-d, %Y" }}</a>
        {% endfor %}
    {% endfor %}
{% endfor %}
```

#### search engine optimazation

- [seo gem](https://help.github.com/articles/search-engine-optimization-for-github-pages/)
- [custom search](https://cse.google.com/)