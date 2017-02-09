# About
This is a user site for knanne

The site can be found at [knanne.github.io](https://knanne.github.io)

# Writing Procedure

  - create new markdown file in `/_posts` directory with filename format `YYYY-MM-DD-Title.md`
  - title and date are inherited from filename  
  - last modified data is inherited from file properties    
  - include the following yaml frontmatter  
    ```yaml
    ---
    #title:
    #date:
    #last-modified-date:
    layout: post
    categories: [cat]
    tags: [tag]
    author: Kain Nanne
    published: True
    ---
    ```
  - utilize `/_drafts` folder for creating unpublished posts (ignored by git)  
  - include an excerpt followed by `<!-- excerpt separator -->`
      - excerpt should be short and concise (not a full sentence), it is used as post description in bootstrap cards  
  - include an introduction and table of contents with the following html and markdown
    ```html
    ...

    <!-- excerpt separator -->

    ## Intro
    Some introductory text here...

    #### Contents
      - [Heading1](#heading1)
      - [Heading2](#heading2)
    <br>
    <br>

    <a id="heading1"></a>
    ## Heading 1
    ...

    <a id="heading2"></a>
    ## Heading 2
    ...
    ```
  - for markdown headings, use only even number for clear differences (`##`, `####`, `######`)  
  - to add gists from GitHub (full files) use the liquid tag `{% gist <ID> %}` with the gist ID  

# Publishing Procedure

  - commit and push to remote repo (no need to `jekll build`, GitHub pages takes care of this)  
    - be sure not to publish sensitive content (use `.gitignore` if needed)  

# To Do:
  - configure and test posts as Accelerated Mobile Pages ([AMP](https://www.ampproject.org/)) using [amp-jekyll](https://github.com/juusaw/amp-jekyll)
  -
