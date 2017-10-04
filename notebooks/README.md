# Writing Notebooks Procedure

  1. **spin up a `jupyter notebook` server and create a `.ipynb` file in `~/_notebooks/jupyter`**
  2. **run `jupyter nbconvert --to html --template template.tpl <NOTEBOOK.ipynb>`**
    - remove `<!DOCTYPE html>` from the `.html` file
  3. **create new `.md` file in `/_notebooks`**
    - add `title` to YAML frontmatter (title needs to be same as `.ipynb` filename, "*slugified*" to access file from [nbviewer](nbviewer.jupyter.org))
    - add `date` to YAML frontmatter
    - author is inherited from YAML defaults in `_config.yml`
  4. **include an excerpt followed by `<!-- excerpt separator -->`**
    - excerpt should be short and concise (not full sentence), it is used as post description in Bootstrap Cards
  5. **embed the html version of the notebook by using `{% include_relative jupyter/<NOTEBOOK>.html %}`**

Optionally, add `publish: False` in YAML front matter to hide notebooks on live site (these are NOT ignored by git!)  

## Sample Notebook Setup

```yaml
---
title: Pandas Visualization
date: '2017-09-30'
---
```

```html
A template for creating notebooks...

<!-- excerpt separator -->

{% include_relative jupyter/pandas_visualization.html %}
```
