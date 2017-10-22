---
categories: [web development]
tags: [jquery]
---

A documentation on how I created a simple back to top button for posts on this site

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Introduction

Have you ever seen a button that magically appears on a site or blog when you scroll all the way to the bottom? Below is a documentation on how to create the one used on this site.  

# Object

Pick your icon from you favorite icon source. I prefer to use [Google's Material Icons](https://google.github.io/material-design-icons/). You will need to import the library in you head scripts for use.  

You can find the icon you want at [material.io/icons/](https://material.io/icons/) and get the slug. Google didn't actually have the exact icon I wanted, a circle with up arrow in the middle, so I simply used the circle with down arrow and flipped it by 180&deg; (see CSS below).

Now include it in your post template.  

```html
<i id="back2top" class="material-icons icon-3d" rel="tooltip" title="Back to Top">arrow_drop_down_circle</i>
```

# Functionality

To make use of it, I implement some jQuery to find the scroll position, and dynamically show the icon when scrolled to bottom. This code adds a buffer of 200 pixels, which can be changed depending on when you want the icon to appear.  

```javascript
$(window).scroll(function(){
    if ($(window).scrollTop() + $(window).height() > $(document).height() - 200) {
        $('#back2top').fadeIn();
    } else {
        $('#back2top').fadeOut();
    }
});
```

And then animate the scrolling back to top of page when clicked.

```javascript
$('#back2top').click(function(){
    $("html, body").animate({ scrollTop: 0 }, 400);
    return false;
});
```

# Style

Below is the custom styling I applied to the icon. What's important is the fixed position at bottom of right corner and the default display as none.  

```css
#back2top {
  display: none;
  position: fixed;
  right: 15px;
  bottom: 15px;
  cursor: pointer;
  font-size: 48px;
  color: #ccc;
  opacity: .5;
  transform: rotate(180deg);
  z-index: 10px;
}
#back2top:hover {
  color: #2a7ae2;
  opacity: 1;
}
```

I also chose to give the icon a shadow to make it pop off the screen more. You can follow the specific [Material Style Guidelines for icons](https://material.io/guidelines/style/icons.html), or implement your own like I have done below.  

```css
.icon-3d {
  text-shadow: 0 4px 8px rgba(0,0,0,0.15);
}
```
