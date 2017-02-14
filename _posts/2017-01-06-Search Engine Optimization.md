---
categories: [web development]
tags: [seo]
---

Notes on Search Engine Optimization (SEO) for this site, and related Google resources

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

## Register Site

Register the site on Google  

- see [what Google says](https://support.google.com/webmasters/answer/34397?hl=en&ref_topic=3309300) about getting your site in their search engine
- refer to [Google Webmasters](https://www.google.com/webmasters)  
- read Google's pdf [Search Engine Optimization
Starter Guide](https://static.googleusercontent.com/media/www.google.com/en//webmasters/docs/search-engine-optimization-starter-guide.pdf)

First add your site, and verify its ownership by adding an the auto generated .html file given by Google to your site's directory.  

Register your sitemap with Google. This site uses the [`jekyll-sitemap gem`](https://github.com/jekyll/jekyll-sitemap) to auto generate `sitemap.xml` which can be found in the `_site` folder.  

## Search Site

This site has an embedded custom search, located at [/search/](https://knanne.github.io/search/). This internal search is the same as searching google.com with `site:mysite.com`.  

- Google's [custom search](https://cse.google.com/)

## Utilize Analytics

Configure Google Analytics  

- register [Google Analytics](https://www.google.com/analytics/)

This site uses a liquid to include the analytics script on every page. A file was created in `/includes` called `google_analytics.html` which is referenced in the site's `head.html`. Note that the actual google analytics id is stored in `config.yml`  
