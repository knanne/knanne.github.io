# Writing Notebooks Procedure

  1. spin up a `jupyter notebook` server and create a `.ipynb` file in `~/_notebooks/jupyter`
  2. run `jupyter nbconvert --to html --template template.tpl <NOTEBOOK.ipynb>`
    - remove `<!DOCTYPE html>` from the `.html` file
  3. **create new `.md` file in `/_notebooks` with filename as notebook `slug`**
    - add `title` to YAML frontmatter
    - add `date` to YAML frontmatter
    - author is inherited from YAML defaults in `_config.yml`
  4. **include an excerpt followed by `<!-- excerpt separator -->`**
    - excerpt should be short and concise (not full sentence), it is used as post description in Bootstrap Cards

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
