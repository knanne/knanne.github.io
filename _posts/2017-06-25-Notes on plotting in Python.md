---
categories: [data visualization]
tags: [python, pandas, matplotlib, jupyter]
---

Helpful scripts and samples for plotting in Python

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Setup

Since [Pandas](https://pandas.pydata.org/) is almost a one stop shop for everything data analysis in python anyway, most plotting is done using `df.plot()` syntax, however, you must import [Matplotlib](https://matplotlib.org/index.html) since this is a dependency. I would also recommend installing [Seaborn](https://seaborn.pydata.org/) for more interesting plot types and statistical features. Plus it has a nice native style.  

This post is also available as a [Jupyter Notebook]({{ site.nbviewer }}/pandas_visualization.ipynb)  

## Dependencies

```python
import pandas as pd
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt
import seaborn
```

## Display

Couple options for visualizing in a Jupyter Notebook. Either present static charts `inline`, embed them as interactive elements using `notebook` setting, or open the chart in a new windows from backend usiing `gtk`.  [source](http://ipython.readthedocs.io/en/stable/interactive/plotting.html)

```python
#matplotlib inline
%matplotlib notebook
#%matplotlib gtk
```

## Style

Call `plt.style.available` to show options, then set the style of choice.  

```python
plt.style.use('seaborn-white')
```

# Visualizations

Below are a few examples of basic plots, and simple code on how to use other features like formatting and labels.  

## Dummy Data  

```python
df = pd.DataFrame(data=np.random.rand(24,4),
                  index=pd.date_range(end=pd.datetime.now(), periods=24, freq='MS'),
                  columns=['A', 'B', 'C', 'D'])
```

## Plot Categorical Data Over Time  

```python
fig, ax = plt.subplots(figsize=(12,8))

df.plot(ax=ax)

ax.set(ylabel='Categories', xlabel='Time', title='Category Volume Over Time')

fig.tight_layout(pad=2)
fig.show()

fig.savefig('category_volume_over_time.png', transparent=True, dpi=300, bbox_inches='tight')
```

![Category Volume Over Time]({{ site.baseurl }}/assets/img/posts/category_volume_over_time.png)  

## Transform

Group data over time periods. Refer to [Pandas Offset Aliases](http://pandas.pydata.org/pandas-docs/stable/timeseries.html#offset-aliases)  

```python
df = df.groupby(pd.TimeGrouper('1A')).sum()
```

## Plot Categorical Data Over Time Groups

```python
fig, ax = plt.subplots(figsize=(12,8))

df.plot(kind='bar', ax=ax)

ax.set(ylabel='Categories', xlabel='Time', title='Category Volume per Year End')

# auto format xaxis labels as date
fig.autofmt_xdate()

# custom format xaxis date labels
# current bug in pandas doesn't allow the following
# see https://github.com/pandas-dev/pandas/issues/1918
#ax.xaxis_date()
#ax.xaxis.set_major_locator(mpl.dates.YearLocator())
#ax.xaxis.set_major_formatter(mpl.dates.DateFormatter('%d %b %Y'))
# so instead we manually set xaxis labels to our custom formatted df index as series of strings
ax.xaxis.set_major_formatter(plt.FixedFormatter(df.index.to_series().dt.strftime('%d %b %Y')))

# annotate data labels onto vertical bars
# see https://matplotlib.org/users/annotations_guide.html
for bar,(col,ix) in zip(ax.patches, pd.MultiIndex.from_product([df.columns,df.index])):
    ax.annotate(str(round(df.loc[ix,col],2)), xy=(bar.get_x()+.01, bar.get_height()-.5), color='white')

fig.tight_layout(pad=2)
fig.show()

fig.savefig('category_volume_per_year_end.png', transparent=True, dpi=300, bbox_inches='tight')
```

![Category Volume per Year End]({{ site.baseurl }}/assets/img/posts/category_volume_per_year_end.png)  

# Resources

- [Matplotlib docs](https://matplotlib.org/contents.html)  
- [Pandas Visualization docs](https://pandas.pydata.org/pandas-docs/stable/visualization.html)  
- [Seaborn docs](https://seaborn.pydata.org/api.html)  

Chris Moffitt at Practical Business Python has a [great tutorial and helpful infographic](http://pbpython.com/effective-matplotlib.html) on matplotlib  
