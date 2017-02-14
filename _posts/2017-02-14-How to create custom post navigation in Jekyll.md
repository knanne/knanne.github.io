---
layout: post
categories: [web development]
tags: [jekyll, jquery, bootstrap, kramdown]
---

A documentation on how I created a fancy post navigation for this site  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

## introduction

This post is an explanation of the custom Jekyll-post navigation I came up with for this site (as shown on this post).  

So the goal here was to create some sort of navigation that would show post contents and allow for linking to a heading. And of course i wanted to automate this for each post with as little work as possible when writing a new post.  

My initial idea was a second fixed navbar above post content, as I like Bootstrap and find it easy to implement. I then found [Scrollspy](http://v4-alpha.getbootstrap.com/components/scrollspy/) within the Bootstrap docs and thought that was cool. OK, so go for a fixed navbar with scrolsspy functionality.  

**TL;DR**: skip to [Implementation]({{ site.base_url }}{{ page.url }}#implementation) to simply steal my code

## attempt 1

First, I though this would be simple to implement using YAML and Liquid. The idea was create a list of sections in the post's front matter and then call that data for constructing a navbar in my post template. This was straightforward and worked perfectly, with only one hiccup, I needed to include a `<div>` before each heading in markdown to link the heading to the navbar. The components of this are outlined below.  

Front Matter  

```yaml
sections:
- Intro
- Gettings Started
- Advanced
```

Liquid construction of navbar  

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

jQuery to apply the scrollspy to navbar element  

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

Element to ID each heading for navigation  

```html
<div class="heading" id="getting_started"></div>
```

I quickly realized I didn't want this because I had re list each section in the front matter, and then again repeat myself in an extra `<div>`. On top of that everything had to be spelled exactly right to work.  

## more research

In researching a way to make the above easier, I started to build plugin in Ruby to auto-generate the post front-matter by iterating through posts and finding all the headings. But I still needed to link to the headings.  

Also, I stopped the idea of jekyll plugin as soon as I found out, [according to the Jekyll docs](http://jekyllrb.com/docs/plugins/), custom `.rb` files do not run during build on GitHub pages since it is built in `--safe` mode.  

Then I found the default markdown-converter used in Jekyll [auto-generates IDs for headings ](https://kramdown.gettalong.org/converter/html) Could I get these and use them to build a front matter dictionary of sections and section IDs???  

...more research, thinking, research...Ah, Magic is found!  

Kramdown automatically generations a ["Table of Contents"](https://kramdown.gettalong.org/converter/html.html#toc)  

I document how to use this feature in [this post](https://knanne.github.io/posts/creating-a-website-with-jekyll-and-github-pages#code-snippets)

This looks very similar to what I wanted to do (I should have thought of "Table of Contents" from the beginning) ...OK so how can I use it???  

## implementation

So now I just needed to figure out how to utilize the automatically-generated table of contents div, and apply the appropriate formatting and styling to utilize scrollspy, and look just how I wanted. Below each part is documented for you to replicate it.  

#### include auto TOC in post

Stick this in your post above your first heading.  

```markdown
* AUTO TABLE OF CONTENTS
{:toc}
```

#### jQuery to construct navbar, apply scrollspy

Include this jQuery in your scripts files to be run on post template load. Included is some extra styling elements to capitalize headings, and padd them to make sure they are not hidden by the fixed navbar when linked to.  

```javascript
// wrap markdown-toc in navbar div
$('#markdown-toc').wrapAll('<nav id="post-nav" class="navbar post-nav">');

// add scrollspy to post navigation
$('body').scrollspy({target: "#post-nav", offset: 50});

// format toc objects with classes for custom scrollspy
$('#markdown-toc').addClass('nav justify-content-center');
$('#markdown-toc li').addClass('nav-item');
$('#markdown-toc a').addClass('nav-link');

// capitalize headings - because I do not in markdown
$('#markdown-toc a').css({"text-transform": "capitalize"});

// loop thru toc list, get headings
// pad each heading to clear post-nav when linked
$('#markdown-toc li a').each(function(index) {
  heading = $(this).attr('id');
  // remove auto pre text from toc id
  heading = heading.replace("markdown-toc-", "")
  $("#"+heading).css({"padding-top": "50px"});
});

// fix post navbar on scroll past
var distanceFromTop = $('#post-nav').offset().top;
$(window).scroll(function() {
  var currentScroll = $(window).scrollTop();
  if (currentScroll >= distanceFromTop) {
    $('#post-nav').addClass('fixed-top');
  } else {
    $('#post-nav').removeClass('fixed-top');
  }
});
```

#### CSS to style the navbar

Apply bottom border to heading in navbar when active. And bring the navbar off the z axis to make sure it clears other elements like quotes in markdown.

```css
nav a.active {
  border-bottom: 1px solid #2a7ae2;
}
.post-nav {
  z-index: 10;
}
```
