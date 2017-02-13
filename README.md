# About
This is a user site for knanne

The site can be found at [knanne.github.io](https://knanne.github.io)

# Writing Posts Procedure

  1. create new markdown file in `/_posts` directory with filename format `YYYY-MM-DD-Title.md`
    - title and date are inherited from filename
    - author is inherited from yaml defaults in `_config.yml`
    - last modified data is inherited from file properties using `_plugins\hook-add-last-modified-date.rb`
    - utilize `/_drafts` folder for unpublished posts (also ignored by git)
  2. include an excerpt followed by `<!-- excerpt separator -->`
    - excerpt should be short and concise (not full sentence), it is used as post description in html cards
  3. utilize post navigation with sections
    - include `sections: [Section One, Section Two]` in post yaml front matter
    - prepend each markdown heading with `<div class="heading" id="section_one"></div>`
    - remove sections from post properties to ignore navigation
  4. embed content
    - using markdown syntax
    - add photos with `![<IMAGE>]({{ site.baseurl }}/assets/img/posts/<IMAGE>.png)`
    - add youtube videos with `{% youtube <ID> %}`, which renders as embbedded iframe using `_plugins/youtube.rb`
    - add gists from GitHub use the liquid tag `{% gist <ID> %}` with the gist ID  

  ## sample

    ```yaml
    ---
    categories: [category]
    tags: [tag1, tag2]
    sections:
      - Section One
      - Section Two
    ---
    ```
    ```html
    A template for creating posts...

    <!-- excerpt separator -->

    <div class="heading" id="introduction"></div>

    ## Introduction

    Some text...

    <div class="heading" id="first_paragraph"></div>

    ## First Paragraph

    Some more text...
    ```

# Creating Projects Procedure

# Publishing Procedure

  - commit and push to remote repo (no need to `jekll build`, GitHub pages takes care of this)  
    - be sure not to publish sensitive content (use `.gitignore` if needed)  

# To Do:
  - configure and test posts as Accelerated Mobile Pages ([AMP](https://www.ampproject.org/)) using [amp-jekyll](https://github.com/juusaw/amp-jekyll)
  - write a plugin to automate post navigation further
    - automate the creation of linked div, and front matter list for all major headings in post
    - create a post parameter navigation, default to True
  - continue projects procedure
