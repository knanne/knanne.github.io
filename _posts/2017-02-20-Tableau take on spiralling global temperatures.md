---
categories: [data visualization]
tags: [tableau]
---

How I recreated a popular data visualization in Tableau

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

## background

It all started with a tweet. **[Ed Hawkins](https://twitter.com/ed_hawkins)**, a climate scientist in the National Centre for Atmospheric Science (NCAS) at the University of Reading publicly posted a visualization he had made.  

<div class="d-flex justify-content-center">
<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Spiralling global temperatures from 1850-2016 (full animation) <a href="https://t.co/YETC5HkmTr">https://t.co/YETC5HkmTr</a> <a href="https://t.co/Ypci717AHq">pic.twitter.com/Ypci717AHq</a></p>&mdash; Ed Hawkins (@ed_hawkins) <a href="https://twitter.com/ed_hawkins/status/729753441459945474">May 9, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>

> The animated spiral presents global temperature change in a visually appealing and straightforward way. The pace of change is immediately obvious, especially over the past few decades. The relationship between current global temperatures and the internationally discussed target limits are also clear without much complex interpretation needed. - [Ed Hawkins](http://www.climate-lab-book.ac.uk/2016/spiralling-global-temperatures/)

**Read his follow up post** [here](http://www.climate-lab-book.ac.uk/spirals/)  

## tableau tour

Tableau is doing a tutorial series around The Netherlands. They are calling it [#tableautour](https://twitter.com/search?q=%23tableautour), and the series schedule can be found [here](https://www.tableau.com/learn/series/TableauTour).

Now they are holding a [(RE)Visualize It Competition](https://tableau.egnyte.com/dl/6jxgNujERe) to generate new versions or previously successful visualizations. Having had Tableau experience in the past, and a chance to win Tableau swag...I needed to participate.  

## dataset

The original dataset can be found [here](http://www.metoffice.gov.uk/hadobs/hadcrut4/)  

> HadCRUT4 is a gridded dataset of global historical surface temperature anomalies relative to a 1961-1990 reference period. Data are available for each month since January 1850, on a 5 degree grid. The dataset is a collaborative product of the Met Office Hadley Centre and the Climatic Research Unit at the University of East Anglia. - [website](http://www.metoffice.gov.uk/hadobs/index.html)  

From the Tableau competition resources, **[TDriver7](https://twitter.com/TDriver7)**, generously did half the work already, by providing a data extract (.tde file) included with calculations of the coordinate system for the radar. You can download it [here](https://tableau.egnyte.com/dl/s9n5XwB9jA).  

## tableau

I am not the first to recreate this in Tableau!  

**[Andy Kriebel](https://twitter.com/VizWizBI)**, from The Information Lab, already recreated the visualization in Tableau and shares it publicly [here](https://public.tableau.com/views/RadarCharts/Title?:embed=y&:loadOrderID=0&:display_count=yes&:showTabs=y). You can simply watch him create it in [this YouTube video](https://www.youtube.com/watch?v=ozWUrOBkyF8).  

As far as radar charts in Tableau go, **[Jonathan Trajkovic](https://twitter.com/j_trajkovic)** provides instructions on [how to create a radar chart in Tableau](https://www.tableau.com/about/blog/2015/7/use-radar-charts-compare-dimensions-over-several-metrics-41592)  

## final visualization

So this is what I was able to come up with...  

<div class="d-flex justify-content-center">
<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Contributing my version on <a href="https://twitter.com/ed_hawkins">@ed_hawkins</a> &quot;Spiralling Global Temp&quot; to the <a href="https://twitter.com/hashtag/TableauTour?src=hash">#TableauTour</a> competition, repping <a href="https://twitter.com/UvA_Amsterdam">@UvA_Amsterdam</a> dataviz - <a href="https://twitter.com/TDriver7">@TDriver7</a> <a href="https://t.co/QDJruU9AxK">pic.twitter.com/QDJruU9AxK</a></p>&mdash; Kain Nanne (@knanne) <a href="https://twitter.com/knanne/status/833764886106738689">February 20, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>

View Tableau Workbook below and download it for yourself!  

<div class="d-flex justify-content-center">
<div class='tableauPlaceholder' id='viz1487609187648' style='position: relative'><noscript><a href='#'><img alt='Visualizing Global Temperature Change ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Gl&#47;GlobalTemp-TableauTourComp&#47;VisualizingGlobalTemperatureChange&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='site_root' value='' /><param name='name' value='GlobalTemp-TableauTourComp&#47;VisualizingGlobalTemperatureChange' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Gl&#47;GlobalTemp-TableauTourComp&#47;VisualizingGlobalTemperatureChange&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1487609187648');                    var vizElement = divElement.getElementsByTagName('object')[0];                    vizElement.style.width='1004px';vizElement.style.height='869px';                    var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
</div>
