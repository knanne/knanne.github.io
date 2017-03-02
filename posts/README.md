# Writing Posts Procedure

  1. create new markdown file in `/_posts` directory with filename format `YYYY-MM-DD-Title.md`
    - title and date are inherited from filename
    - author is inherited from yaml defaults in `_config.yml`
    - last modified data is inherited from file properties using `_plugins\hook-add-last-modified-date.rb`
    - utilize `/_drafts` folder for unpublished posts (also ignored by git)
  2. include an excerpt followed by `<!-- excerpt separator -->`
    - excerpt should be short and concise (not full sentence), it is used as post description in html cards
  3. utilize post navigation with Auto TOC and Scrollspy
    - include `* AUTO TABLE OF CONTENTS` followed by `{:toc}` on a new line
    - this utilized kramdown auto toc generation
    - and applies jQuery to style a fixed navbar for each post
    - and utilizes bootstrap scrollspy for follow-along navigation
  4. embed content by:
    - using markdown syntax
    - adding photos with `![<IMAGE>]({{ site.baseurl }}/assets/img/posts/<IMAGE>.png)`
    - adding youtube videos with `{% youtube <ID> %}`, which renders as embbedded iframe using `_plugins/youtube.rb`
    - adding gists from GitHub use the liquid tag `{% gist <ID> %}` with the gist ID
  5. always use `<div class="d-flex justify-content-center"></div>` when embedding html

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
