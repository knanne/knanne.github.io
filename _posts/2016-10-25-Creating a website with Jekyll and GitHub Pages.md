---
categories: [web development]  
tags: [ruby, jekyll, github, static site generator]  
---

Notes on using Jekyll for creating a website on GitHub pages  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

## Introduction

So what is this all about...

**Jekyll**

> Jekyll is a simple, blog-aware, static site generator. It takes a template directory containing raw text files in various formats, runs it through a converter (like Markdown) and our Liquid renderer, and spits out a complete, ready-to-publish static website suitable for serving with your favorite web server. - [website](https://jekyllrb.com/)  

**GitHub Pages**

> GitHub Pages is a static site hosting service, and is designed to host your personal, organization, or project pages directly from a GitHub repository. - [website](https://pages.github.com/)  

## Resources

- a guy named Michael Lee is writing [Field Guide to Jekyll](https://michaelsoolee.com/jekyll-field-guide/)
- refer to the Jekyll [docs](https://jekyllrb.com/docs/home/)
- get help from GitHub Pages [docs](https://help.github.com/categories/github-pages-basics/)

## Getting Started

<mark>installation of Jekyll on Windows is not so straightforward</mark>

[This](https://jekyllrb.com/docs/windows/#installation) is the best place to find installation instructions  

Assuming you have Jekyll and GitHub Pages Ruby gems installed, initialize a new site  

```shell
jekyll new <SITE>
```

This will install github-pages default files, including the [minima](https://github.com/jekyll/minima) theme.  

Serve the site locally with the following  

```shell
jekyll serve
# alternately, if you receive an error due to inconsitent installations
# between system and gemfile.lock (required dependencies)
bundle exec jekyll serve
```

Find the app hosted at [http://localhost:4000/](http://127.0.0.1:4000)  

## Customization  

#### theme  

To remove the default theme, remove the `gem 'minima'` in Gemfile, and remove `theme='minima'` settings in `_config.yml`. Otherwise import a local css/sass file to simply override theme settings.  

#### harness the jekyll engine  

- refer to the jekyll [cheat sheet](http://jekyll.tips/jekyll-cheat-sheet/)  

#### use YAML frontmatter  

- read what Jekyll advises on [front matter](https://jekyllrb.com/docs/frontmatter/)

#### use liquid for automation  

> "Liquid is an open-source template language created by Shopify and written in Ruby." - [website](https://shopify.github.io/liquid/)  

#### plugins

Plugins written in Ruby and either store in your `_plugins` dir or installed with a gem are able to add a lot of convenience and features to a site.

But, [according to the Jekyll docs](http://jekyllrb.com/docs/plugins/), custom `.rb` files do not run during build on GitHub pages since it is built in `--safe` mode.

Therefore only install from gem for now if you are hosting on GitHub pages.

#### search engine optimization

- use the [jekyll seo gem](https://help.github.com/articles/search-engine-optimization-for-github-pages/)
- create a [jekyll sitemap](https://github.com/jekyll/jekyll-sitemap)

#### site comments

This blog implements the comments powered by Google Plus (see bottom of post). I have not found any official documentation on their [web API site](https://developers.google.com/+/web/), but found sample code [here](https://gist.github.com/chuckbutler/fce8077a0161cff6b489), and a blog post describing the implementation [here](https://floaternet.com/gcomments).

Other notable options I have seen include:
- [Disqus](https://disqus.com/)
- [Facebook](https://developers.facebook.com/docs/plugins/comments)

#### social buttons

- GitHub various [buttons](https://buttons.github.io/)
- Google +1 [button](https://developers.google.com/+/web/+1button/)
- Twitter Tweet [button](https://dev.twitter.com/web/tweet-button)
- Facebook like [button](https://developers.facebook.com/docs/plugins/like-button)
- LinkedIn various [buttons](https://developer.linkedin.com/plugins)

## Code Snippets


Here are some code snippets that may come in handy when trying to code your own site. Some of these are implemented on this site.  

#### recent posts summary

```html
{% raw %}{% for post in site.posts limit : 3 %}
    <h3><a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
    <p class="text-muted">{{ post.date | date: "%b %-d, %Y" }}</p>
    <p>{{ post.excerpt | strip_html }}</p>
{% endfor %}{% endraw %}
```

#### posts by category list

```html
{% raw %}{% for category in site.categories %}
    <h3>{{ category | first }}</h3>
    {% for posts in category %}
        {% for post in posts %}
            <a href="{{ post.url }}">{{ post.title }}</a>
            <a class="text-muted"><small>{{ post.date | date: "%b %-d, %Y" }}</small></a>
        {% endfor %}
    {% endfor %}
{% endfor %}{% endraw %}
```

#### post by sorted tags

```html
{% raw %}{% capture tags %}
  {% for tag in site.tags %}
    {{ tag[0] | url_encode }}
  {% endfor %}
{% endcapture %}
{% assign sortedtags = tags | split:' ' | sort %}

{% for tag in sortedtags %}
{% assign t = tag | replace: '+', ' ' %}
  <h3 id="{{ tag }}">{{ t }}</h3>
  <ul>
    {% for post in site.tags[t] %}
      <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <span class="text-muted"><small>Published: {{ post.date | date: "%b %-d, %Y" }}</small></span>
      </li>
    {% endfor %}
  </ul>
{% endfor %}{% endraw %}
```

#### automatic table of contents

The default markdown converter for Jekyll is **Kramdown**, which generates IDs by default for headings and allows for the auto generation of a table of contents. Simply include the following snipped in your markdown post file.  

```Markdown
# Contents
{:.no_toc}

* Will be replaced with the ToC, excluding the "Contents" header
{:toc}
```

[source](https://kramdown.gettalong.org/converter/html.html#toc) from Kramdown docs  

You can specify which headings to be used in the TOC in your `config.yml`  

```yaml
markdown: kramdown
kramdown:
  toc_levels: 1..4 # only using h1 thru h4 to generate table of contents in posts
```
