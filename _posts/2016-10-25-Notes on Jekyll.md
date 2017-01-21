---
layout: post  
categories: [tech]  
tags: [ruby, jekyll, static site generator]
---

Notes on using Jekyll for creating a website on GitHub pages.  

<!--excerpt separator -->

## Intro to Jekyll

- [jekyll website](https://jekyllrb.com/)  
- [github pages](https://pages.github.com/)  

## Resources

- a guy named Michael Lee is writing [Field Guide to Jekyll](https://michaelsoolee.com/jekyll-field-guide/)

## Getting Started

jekyll provides specific [install instructions](http://jekyll.tips/jekyll-casts/install-jekyll-on-windows/) for windows, but for current github pages integration, uses the following

1. install chocolatory  
2. install ruby 2.2.4, or downgrade  
3. cofigure ruby installation  
4. install gem github-pages  

source: [jekyllrb](https://jekyllrb.com/docs/windows/#installation),
[jwillmer](https://jwillmer.de/blog/tutorial/how-to-install-jekyll-and-pages-gem-on-windows-10-x46#install-github-gem)  

###### init blog  
```shell
jekyll new myBlog
```

This will install github-pages default files, including the [minima](https://github.com/jekyll/minima) theme.  

###### serve blog  
```shell
jekyll serve
# alternately, if you receive an error due to inconsitent installations
# between system and gemfile.lock (required dependencies)
bundle exec jekyll serve
```

find the app hosted at [http://localhost:4000/](http://127.0.0.1:4000)  

add `-watch` for auto updates, **currently not supported in windows**  

## Customization  

#### theme  

To remove the default theme, remove the `gem 'minima'` in Gemfile, and remove `theme='minima'` settings in _config.yml.  

#### harnessing jekyll engine  

- refer to jekyll [cheat sheet](http://jekyll.tips/jekyll-cheat-sheet/)  

#### using liquid  

> "Liquid is an open-source template language created by Shopify and written in Ruby."

- ref liquid [website](https://shopify.github.io/liquid/)  

###### get recent posts and print title, dates and excerpts  
```html
{% raw %}{% for post in site.posts limit : 3 %}
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
    <p class="text-muted">{{ post.date | date: "%b %-d, %Y" }}</p>
    <p>{{ post.excerpt | strip_html }}</p>
{% endfor %}{% endraw %}
```

###### get all posts organized by category  
```html
{% raw %}{% for category in site.categories %}
    <h3>{{ category | first }}</h3>
    {% for posts in category %}
        {% for post in posts %}
            <a href="{{ post.url }}">{{ post.title }}</a>
            <a class="text-muted" style="font-size: 12px">{{ post.date | date: "%b %-d, %Y" }}</a>
        {% endfor %}
    {% endfor %}
{% endfor %}{% endraw %}
```

## Search Engine Optimization

- use the [jekyll seo gem](https://help.github.com/articles/search-engine-optimization-for-github-pages/)
- create a [jekyll sitemap](https://github.com/jekyll/jekyll-sitemap)

## Blog Post Comments

This blog implements the comments powered by Google Plus (see bottom of post). I have not found any official documentation on their [web API site](https://developers.google.com/+/web/), but found sample code [here](https://gist.github.com/chuckbutler/fce8077a0161cff6b489), and a blog post describing the implementation [here](https://floaternet.com/gcomments).

Other notable options I have seen include:
- [Disqus](https://disqus.com/)
- [Facebook](https://developers.facebook.com/docs/plugins/comments)

## Blog Social buttons

- GitHub various [buttons](https://buttons.github.io/)
- Google +1 [button](https://developers.google.com/+/web/+1button/)
- Twitter Tweet [button](https://dev.twitter.com/web/tweet-button)
- Facebook like [button](https://developers.facebook.com/docs/plugins/like-button)
