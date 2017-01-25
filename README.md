# About
This is a user site for knanne

To be continued...

# Writing Procedure
  - create new file in `/_posts` directory
  - include the following yaml frontmatter
    ```yaml
    ---
    layout: post
    categories: []
    tags: []
    author: Kain Nann
    ---
    ```
  - include an excerpt followed by `<!-- excerpt separator -->`
  - for markdown headings, use only even number for clear differences (`##`, `####`, `######`)

# Publishing Procedure
  - commit and push to remote repo (no need to `jekll build`, GitHub pages takes care of this)
  - be sure not to publish sensitive content (use `.gitignore` if needed)

# To Do:
  - fix some list formatting on Posts
  - create about page (with cv)
