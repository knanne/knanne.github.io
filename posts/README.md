# Writing Posts Procedure

  1. **create new `.md` file in `/_posts` with format `YYYY-MM-DD-hyphen-delimited-lowercase-title.md`**
    - title and creation dates are inherited from filename
    - <mark>NOTE:</mark> use a `hyphen-delimited-lowercase-title` so that the page url is consistent whith the AMP url used by [amp-jekyll](https://github.com/juusaw/amp-jekyll)
    - author (along with other meta tags) is inherited from YAML defaults in `_config.yml`
    - <del>last modified data is created as a liquid property using [jekyll-last-modified-at](https://github.com/gjtorikian/jekyll-last-modified-at)`</del> (Not whitelisted on GitHub Pages, monitor `~/pages-gem/pull/119`)  
  2. **add category and tags**
    - see [/posts/categories](https://knanne.github.io/posts/categories) for list of existing categories
    - see [/posts/tags](https://knanne.github.io/posts/tags) for list of existing tags
  3. **include an excerpt followed by `<!-- excerpt separator -->`**
    - excerpt should be short and concise (not full sentence), it is used as post description in Bootstrap Cards
  4. **include post navigation with Auto TOC and Custom Nav**
    - include `* AUTO TABLE OF CONTENTS` followed by `{:toc}` on a new line
      - utilizes Kramdown auto toc generation
      - applies jQuery to style a fixed navbar for each post
      - utilizes Bootstrap Scrollspy for follow-along navigation

## Sample Post Setup

```yaml
---
categories: [category]
tags: [tag1, tag2]
---
```

```html
A template for creating posts...

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

## Introduction
Some text...

## First Paragraph
Some more text...
```

# Embed Content

  - use markdown syntax (e.g. quotes, text formatting etc.), ref [GitHub's Guide](https://guides.github.com/features/mastering-markdown/)
  - add latex with math blocks `$$...$$`, enabled by [MathJax](https://www.mathjax.org/)
  - add photos with `![<IMAGE>]({{ site.baseurl }}/assets/img/posts/<IMAGE>.png)`
    - images are fluid, 100% width and auto height
    - alternatively append `{:class="img-sm"}` to the end for adopting image class with only 50% of width, so full example is: `![<IMAGE>]({{ site.baseurl }}/assets/img/posts/<IMAGE>.png){:class="img-sm"}`
  - embed HTML inside a `<div class="d-flex justify-content-center"></div>` container

# Pin

This site pins notes to a "Recent Posts" section on https://knanne.github.io/posts/. As defined in the `_config.yml`, all posts have pin set to True by default. Currently only the last 3 most recent posts will be shown. To exclude a post from being pinned, set `pin: False` in the post's YAML frontmatter.  

# Drafts

Utilize `/_drafts` folder for unpublished posts (also ignored by git)  

# AMP

<del>This site utilizes [AMP](https://www.ampproject.org/) to make posts render quicker and hopefully reach further in Google Searches.  </del>

<del>[Amp_Jekyll](https://github.com/juusaw/amp-jekyll) takes care of the heavy lifting, using our own custom `amp.html` template in `~/_layouts`.  </del>

Not on GitHub-Pages whitelisted plugins. Monitor Jekyll dev instead, `~/jekyll/issues/3041`, different post formats could become native feature in Jekyll soon.  
