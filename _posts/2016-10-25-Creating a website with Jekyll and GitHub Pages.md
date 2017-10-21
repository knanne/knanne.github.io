---
categories: [web development]  
tags: [ruby, jekyll, github, static site generator]  
---

Notes on using Jekyll for creating a website on GitHub pages  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Intro

So what is this all about...

**Jekyll**

> Jekyll is a simple, blog-aware, static site generator. It takes a template directory containing raw text files in various formats, runs it through a converter (like Markdown) and our Liquid renderer, and spits out a complete, ready-to-publish static website suitable for serving with your favorite web server. - [website](https://jekyllrb.com/)  

**GitHub Pages**

> GitHub Pages is a static site hosting service, and is designed to host your personal, organization, or project pages directly from a GitHub repository. - [website](https://pages.github.com/)  

# Resources

- refer to the [Jekyll docs](https://jekyllrb.com/docs/home/)
- refer to the [GitHub Pages docs](https://help.github.com/categories/github-pages-basics/)
- a guy named Michael Lee is writing [Field Guide to Jekyll](https://michaelsoolee.com/jekyll-field-guide/)

# Getting Started

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

# Customization  

With some creativity, you can hack your website into anything you want. But there is a lot of useful functionality out of the box with Jekyll. For example, make sure you understand how to use the following features.  

## Theme  

To remove the default theme, remove the `gem 'minima'` in Gemfile, and remove `theme='minima'` settings in `_config.yml`. Otherwise import a local css/sass file to simply override theme settings.  

## Gems

Jekyll is written in Ruby, a programming language which refers to their libraries or packages as Gems, and therefore Jekyll uses Gems for third-party features.  

Learn about [Jekyll gems and the bundler](http://jekyll.tips/jekyll-casts/gemfiles-and-the-bundler/)  

add a `gem` to your `config.yml` file  

```ruby
gems:
  - jekyll-last-modified-at
```
and run  

```shell
gem install jekyll-last-modified-at
```

Or, add gems to `Gemfile`  

```ruby
group :jekyll_plugins do
   gem "jekyll-last-modified-at"
end
```

If you modify the Gemfile, you must then run `bundle install`  

## YAML Frontmatter  

What the heck is YAML?

> YAML is a human friendly data serialization standard for all programming languages. - [website](http://yaml.org/)

It is basically a markup language used to store configuration data. Jekyll sites commonly use it to store data on blog posts like dates, and tags and the like.    

- read what Jekyll advises on [front matter](https://jekyllrb.com/docs/frontmatter/)

## Liquid for Automation  

What the heck is Liquid?  

> "Liquid is an open-source template language created by Shopify and written in Ruby." - [website](https://shopify.github.io/liquid/)  

It is basically a language for dynamically rendering templates without any server-side processing. But it also allows us to reuse (HTML) templates, embed templates in other templates, and combined with the Jekyll engine using YAML data, we can even programmatically access and render our entire site's content. For examples, checkout the [Code Snippets](#code-snippets) below.  

## Jekyll Engine  

What do they mean by "Jekyll Engine"? It's basically the combination of Ruby, Liquid and YAML to give you access to all site content dynamically. For more, refer to the [Jekyll cheat sheet](http://jekyll.tips/jekyll-cheat-sheet/).  

## Plugins

Custom plugins can be written in Ruby and either stored in your `_plugins` dir, or installed through a Gem, and can add a lot of convenience and features to a site.  

However, [according to the Jekyll docs](http://jekyllrb.com/docs/plugins/), custom `.rb` files do not run during build on GitHub pages since it is built in `--safe` mode. Therefore only install from available approved gems for now if you are hosting on GitHub pages.  

## Collections

Check out Jekyll's documentation on [Collections](https://jekyllrb.com/docs/collections/) for added functionality. This site uses collections to manage "Notebooks" and "Projects", separate from "Posts".  

## Data

Check out Jekyll's documentation on [Data Files](https://jekyllrb.com/docs/datafiles/) for added functionality. This site uses data files to manage added information on collections, like "Projects".  

## Search Engine Optimization

- use the [jekyll seo gem](https://help.github.com/articles/search-engine-optimization-for-github-pages/)
- create a [jekyll sitemap](https://github.com/jekyll/jekyll-sitemap)

# Blog

Most people use Jekyll for creating a blog, or at least sharing code snippets and notes in some form of posts. I am doing the same on this site.  

## Embedding Content

Of course in a basic HTML page, you have the freedom to create whatever you want. If you are using markdown, which this site uses, to create your posts, it may be a bit more mysterious although possible none the less.  

### Basic Content
- use markdown syntax for assing code blocks, quotes, text formatting and the like. Refer to [GitHub's Guide on Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- add latex with math blocks `$$...$$`, enabled by [MathJax](https://www.mathjax.org/)
- add photos with `![<IMAGE>]({{ site.baseurl }}/path/to/image.png)`
- embed HTML inside a `<div></div>` container

### GitHub Gists

Embed a larger code snippet, posted on [GitHub Gists](https://gist.github.com/), by simply adding the following HTML in your markdown post.  

```html
<div>
  <script src="https://gist.github.com/<USERNAME>/<GIST-ID>.py"></script>
</div>
```

### Jupyter Notebooks

[Jupyter Notebooks](http://jupyter.org/) are becoming an increasingly popular way to code quickly, as well as share fully documented data science workflows.  

The easiest way to add a Jupyter notebook to your post is to [convert it to HTML using nbconvert](https://nbconvert.readthedocs.io/en/latest/usage.html), then embed simply use Liquid to include it in your markdown post. The conversion from the command line would like something like this `jupyter nbconvert --to html <NOTEBOOK.ipynb>`, and to include it use `{% raw %}{% include_relative path/to/<NOTEBOOK>.html %}{% endraw %}` making sure the post is in a subdirectory of the post (or use normal `include` if the notebook is in your `_includes` folder)  

Note, you can always link to a free rendering of your notebook on Github using [Jupyter nbviewer](http://nbviewer.jupyter.org/). An example link would look like the following:  

`http://nbviewer.jupyter.org/github/<USERNAME>/<PROJECT>/blob/master/path/to/<NOTEBOOOK>.ipynb`  

## Site Comments

This blog implements the comments powered by Google Plus (see bottom of post). I have not found any official documentation on their [web API site](https://developers.google.com/+/web/), but found sample code [here](https://gist.github.com/chuckbutler/fce8077a0161cff6b489), and a blog post describing the implementation [here](https://floaternet.com/gcomments).

Other notable options I have seen include:
- [Disqus](https://disqus.com/)
- [Facebook](https://developers.facebook.com/docs/plugins/comments)

## Social Buttons

- GitHub various [buttons](https://buttons.github.io/)
- Google +1 [button](https://developers.google.com/+/web/+1button/)
- Twitter Tweet [button](https://dev.twitter.com/web/tweet-button)
- Facebook like [button](https://developers.facebook.com/docs/plugins/like-button)
- LinkedIn various [buttons](https://developer.linkedin.com/plugins)

# Code Snippets

Here are some code snippets that may come in handy when trying to code your own site. Some of these are implemented on this site.  

## Recent Posts Summary

```html
{% raw %}{% for post in site.posts limit : 3 %}
    <h3><a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
    <p class="text-muted">{{ post.date | date: "%b %-d, %Y" }}</p>
    <p>{{ post.excerpt | strip_html }}</p>
{% endfor %}{% endraw %}
```

## Posts by Category List

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

## Post by Sorted Tags

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

## Automatic Table of Contents

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
