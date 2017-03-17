---
categories: [web development]
tags: [rss, javascript, bootstrap, yql]
---

How I created a personalized and custom RSS feed reader for this site, in (almost) pure JavaScript and Bootstrap

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

## background

Open chrome to google news homepage, receiving constant email newsletters, multiple browser tabs always open, too many news aggregator apps to keep track of - does this sound familiar? This was my problem.  

I love reading and browsing the internet, and I am eager to subscribe to new blogs and sites I find interesting and could learn from. But despite the numerous news aggregators or similar services I used, not a single one supports *ALL* the different sites I wanted to subscribe to. And as nice as mobile friendly email newsletters are, it would be much nicer to have them standardized and viewable in a single easy to read dashboard.  

Enter my search for an open sourced, customizable, and embeddable, RSS feed reader.  

Since creating this site I have wanted to use it as a central repository for public facing notes, and information I could easily access from anywhere. And if I am already here regularly looking for my notes, why not create the homepage as a go to place for my news and internet updates?  

**Objective:** Create a simple and good looking dashboard to display RSS content from any source.  

Features I wanted:  

  - completely customizable
  - use Bootstrap 4 cards
  - support any RSS feeds
  - mobile friendly

#### TL;DR

Skip down to the  [Development](https://knanne.github.io/posts/how-to-create-a-custom-rss-reader#development) section to simply steal my code.  

## requirements

Due to this site being hosted on GitHub Pages, no server-side processing is supported. Therefore, any additional processing, like getting RSS feeds, parsing and printing will need to be in client-side scripts.  

This means a pure JavaScript solution is needed, with no external libraries (e.g. node.js)  

## research

Things I learned:
  - an RSS feed is simply XML data
  - natively requesting data from another domain is prohibited
  - not all RSS data is the same

#### data type

Despite all being XML, there are many forms of what feeds look like (e.g. Atom, RSS, Feedburner etc.) and they are all slightly different in naming convention and structure.

Looking into [parsing XML in pure JavaScript](http://stackoverflow.com/questions/10943544/how-to-parse-an-rss-feed-using-javascript) looks like it could lead to more problems.

The simplest data to process would be JSON, especially when datasources have different keys and tree structures. It would be nice to be able to standardize all feeds into a similar JSON object.  

#### cross-domain origin problem

The same-domain policy disallows any cross-domain requests.  

Common solutions to this problem is to add a proxy to the request, or use an external API or extension which is allowed to make cross-domain requests.  

Some examples of the proxy method are shown in [this stackoverflow answer](http://stackoverflow.com/questions/15005500/loading-cross-domain-html-page-with-ajax/17299796#17299796).  

The jQuery docs from 2015 show an example [using the YQL API in an Ajax call](https://learn.jquery.com/ajax/working-with-jsonp/). So it seems like this may be a recommended solution.  

#### inconsistent data

During the parsing of feeds process, I found out the JSON dictionaries were really not consistent. Some elements were values, some arrays, and some more objects. Therefore in the final function there are many checks for identifying the type of an object first (e.g. author) and then finding the necessary information based on it (e.g. author, author.content, or author.name etc.).

## solution

I decided to utilize an external API to parse the XML and return standardized JSON objects. This allows for consistent data to work with and removes a lot of work.  

The dashboard will be built using [Bootstrap 4  Cards](https://v4-alpha.getbootstrap.com/components/card/) formatted with the `.card-columns` class to be able to dynamically add as many feeds as I want.  

Since I knew I wanted to include a Google News feed, because they already aggregate so well, I made sure to follow [what guidelines I could find](https://support.google.com/news/publisher/answer/4203?hl=en) and standardize based on these rules (e.g. citations, links to original, etc.).  

#### dependencies

Unfortunately the [Google Feed API](https://developers.google.com/feed/) has been **deprecated** as of December, 2016. This seems to have been a good solution and many people are [looking for an alternative](http://stackoverflow.com/questions/34016263/real-alternative-for-google-feed-api).  

The dependency used is the [Yahoo Query Language API](https://developer.yahoo.com/yql/).  

## development

The solution I developed was inspired by [this code snippet](https://codepen.io/markhillard/pen/jJDls).  

#### container

Create a container where the feed cards will live using Bootstrap class `card-columns`. During the build function below, a Bootstrap card will be built for each feed and appended to the DOM inside the `#feeds` div.  

```html
<div id="feeds" class="card-columns">
  <!-- feeds get appended here -->
</div>
```

#### build function

The Gist below contains the worker function to build a card for each feed and append it to the DOM.  

I reuse a few maker functions when building card header, block, and footer. The basic logic if for each feed url is:  

  - make query, get JSON
  - dynamically get content
  - build a string of html elements that represent the card
  - append the card string to the container
  - repeat

<div class="d-flex justify-content-center">
  <script src="https://gist.github.com/knanne/3bcb3daad9faa1ab072a731d96ff2ae7.js"></script>
</div>

#### feeds list

Create a dynamic array of the RSS feeds you want to follow. Some example feeds are presented below.

```javascript
feeds = ['https://news.google.com/news?topic=tc&output=rss', // google news - technology
         'http://feeds.feedburner.com/GDBcode', // google developer blog
         'http://feeds.feedburner.com/blogspot/gJZg', // google research blog
]
```

#### get feeds

A function to loop thru each feed and run the build function.

```javascript
function get_feeds() {
  $('#feeds').empty();
  feeds.forEach(function (url, i) {
    buildFeedCard(url, '#feeds', i);
  });
};
```

#### run on page load

Call the function on page load.

```javascript
window.onload = function() {
  get_feeds();
};
```

#### (optional) refresh button

Alternatively to on page load, we can create a refresh button to manually re-pull the feeds and build the cards.  

```html
<div class="d-flex justify-content-end"><button type="button" class="btn btn-primary btn-sm" onclick="get_feeds()">Refresh</button></div>
```

## implementation

The final implementation looks something like the following image. You can check out [my source code](https://github.com/knanne/knanne.github.io/blob/master/_includes/foot_scripts.html) to see how exactly I manage the scripts on this site's footer.  

![Custom RSS Reader]({{ site.baseurl }}/assets/img/posts/custom_rss_reader.png)
