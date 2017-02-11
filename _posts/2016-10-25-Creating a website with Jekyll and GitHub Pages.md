---
layout: post  
categories: [tech]  
tags: [ruby, jekyll, github, static site generator]  
sections:
- Introduction
- Resources
- Getting Started
- Customization
- Code Snippets
---

Notes on using Jekyll for creating a website on GitHub pages  

<!-- excerpt separator -->

<div class="heading" id="intro"></div>

## Introduction

So what is this all about...

**Jekyll**

> Jekyll is a simple, blog-aware, static site generator. It takes a template directory containing raw text files in various formats, runs it through a converter (like Markdown) and our Liquid renderer, and spits out a complete, ready-to-publish static website suitable for serving with your favorite web server. - [website](https://jekyllrb.com/)  

**GitHub Pages**

> GitHub Pages is a static site hosting service, and is designed to host your personal, organization, or project pages directly from a GitHub repository. - [website](https://pages.github.com/)  

<div class="heading" id="resources"></div>

## Resources

- a guy named Michael Lee is writing [Field Guide to Jekyll](https://michaelsoolee.com/jekyll-field-guide/)
- refer to the Jekyll [docs](https://jekyllrb.com/docs/home/)
- get help from GitHub Pages [docs](https://help.github.com/categories/github-pages-basics/)

<div class="heading" id="getting_started"></div>

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

<div class="heading" id="customization"></div>

## Customization  

#### theme  

To remove the default theme, remove the `gem 'minima'` in Gemfile, and remove `theme='minima'` settings in `_config.yml`. Otherwise import a local css/sass file to simply override theme settings.  

#### harness the jekyll engine  

- refer to the jekyll [cheat sheet](http://jekyll.tips/jekyll-cheat-sheet/)  

#### use YAML frontmatter  

- read what Jekyll advises on [front matter](https://jekyllrb.com/docs/frontmatter/)

#### use liquid for automation  

> "Liquid is an open-source template language created by Shopify and written in Ruby." - [website](https://shopify.github.io/liquid/)  

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

<div class="heading" id="code_snippets"></div>

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

#### include post navigation

I thought it would be nice to implement a dynamic navigation element for when scrolling through posts on this site, as I have seen this throughout the web for documentation and tutorials. So I built an automated post navigation myself using tools that were already integrated in the site (Liquid, YAML, JavaScript, Bootstrap). Below is the template.  

Include a sections list in your post frontmatter, like this post for example:  

```yaml
sections:
- Introduction
- Resources
- Getting Started
- Customization
- Code Snippets
```

Then include an html element to ID each heading for navigation. Be sure to include a space in between the div and the heading. ID of heading needs to be lowercase, and spaces should be replaced with "_".  

```html
<div class="heading" id="code_snippets"></div>

## Code Snippets
```

Include a naviation in your `post.html` layout using Liquid to access the post sections. The included IF statement allows to ignore navigation if you don't include sections in your post frontmatter.  

```html
{% raw %}{% if page.sections %}
  <nav id="post-nav" class="navbar post-nav">
    <ul class="nav justify-content-center">
      {% for section in page.sections %}
        <li class="nav-item">
          <a class="nav-link {% if forloop.first %}active{% endif %}" href="#{{ section | replace: ' ', '_' | downcase }}">{{ section }}</a>
        </li>
      {% endfor %}
    </ul>
  </nav>
{% endif %}{% endraw %}
```

This site utilizes Bootstrap Scrollspy for navigating the post on scroll. Therefore I chose to fix the post navigation bar when scrolling a post, and highlight the appropriate section.  

To do this I first include some JavaScript to apply the scrollspy to the post content, as well as fix the post navigation bar after scrolling past it.

```javascript
// add Bootstrap Scrollspy to post navigation
$('body').scrollspy({target: ".post-nav", offset: 50});

// fix post navbar on scroll past
var distanceFromTop = $('.post-nav').offset().top;
$(window).scroll(function() {
  var currentScroll = $(window).scrollTop();
  if (currentScroll >= distanceFromTop) {
    $('.post-nav').addClass('fixed-top');
  }
  else {
    $('.post-nav').removeClass('fixed-top');
  }
});
```

Lastly I included some CSS to apply two style change. First to identify which section is being viewed by underlining it. And second to pad the top of each heading, so it is not covered by the fixed navbar when navigated to.

```css
nav a.active {
  border-bottom: 1px solid #2a7ae2;
}
.post-content .heading {
  padding-top: 70px;
}
```
