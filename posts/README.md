# Writing Posts Procedure

  1. **create new `.md` file in `/_posts` with format `YYYY-MM-DD-Title.md`**
    - title and date are inherited from filename
    - author is inherited from YAML defaults in `_config.yml`
    - <del>last modified data is inherited from file properties using `_plugins\hook-add-last-modified-date.rb`</del>  
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

  - use markdown syntax (e.g. quotes, text formatting etc.)
  - add photos with `![<IMAGE>]({{ site.baseurl }}/assets/img/posts/<IMAGE>.png)`
    - images are fluid, 100% width and auto height
    - alternatively append `{:class="img-sm"}` to have image only 50% of width
  - embed HTML inside a `<div class="d-flex justify-content-center"></div>` container

# Drafts

Utilize `/_drafts` folder for unpublished posts (also ignored by git)  
