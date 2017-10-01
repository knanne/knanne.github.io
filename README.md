[![Build Status](https://travis-ci.org/knanne/knanne.github.io.svg?branch=master)](https://travis-ci.org/knanne/knanne.github.io)  

# About

This is a "static" website for Kain Nanne built with [Jekyll](https://jekyllrb.com/) and hosted on [GitHub Pages](https://pages.github.com/)  

The live site can be found at [knanne.github.io](https://knanne.github.io)  

# Personal Development Notes

## Creating Posts

See [Posts](https://github.com/knanne/knanne.github.io/tree/master/posts) on how to create a post  

## Creating Notebooks

See [Notebooks](https://github.com/knanne/knanne.github.io/tree/master/notebooks) on how to create a notebook  

## Creating Projects

See [Projects](https://github.com/knanne/knanne.github.io/tree/master/projects) on how to create a project

## Local Testing Procedure

  - run `rake test`  
  - run `rake serve`  

## Publishing Procedure

  - commit and push to remote repo (no need to `jekll build`, GitHub pages takes care of this)  
  - be sure NOT to publish sensitive content (use `.gitignore`)  
  - wait for [Travis CI build](https://travis-ci.org/knanne/knanne.github.io) to pass  

## To Do (IDEAS):

  - configure and test posts as Accelerated Mobile Pages ([AMP](https://www.ampproject.org/)) using [amp-jekyll](https://github.com/juusaw/amp-jekyll)
  - add custom notebook (nbviewer) template
  - add projects
  - create `gh-pages` branch and auto push travis-approved build
  - use bower to manage assets
  - create `tests` procedure
  - implement test for html-proofer
  - add linter
