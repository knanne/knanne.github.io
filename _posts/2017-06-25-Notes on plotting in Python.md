---
categories: [Data Visualization]
tags: [Python, Pandas, Matplotlib, Jupyter]
---

Helpful scripts and samples for plotting in Python

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Setup

Since [Pandas](https://pandas.pydata.org/) is almost a one stop shop for everything data analysis in python anyway, most plotting is done using `df.plot()` syntax, however, you must import [Matplotlib](https://matplotlib.org/index.html) since this is a dependency. I would also recommend installing [Seaborn](https://seaborn.pydata.org/) because they many interesting plot types and statistical features. Plus it has a nice native style.  

Pandas has an [extensive documentation](https://pandas.pydata.org/pandas-docs/stable/visualization.html) on how to create plots directly on a DataFrame.  

## Dependencies

```python
# data
import pandas as pd
import numpy as np
# visualization
import matplotlib as mpl
from matplotlib import pyplot as plt
# added visualization library you should get
import seaborn
```

Couple options for visualizing in a Jupyter Notebook. Either present static charts `inline`, embed them as interactive elements using `notebook` setting, or open the chart in a new windows from backend usiing `gtk`.  [source](http://ipython.readthedocs.io/en/stable/interactive/plotting.html)

```python
%matplitlib inline
%matplitlib notebook
%matplitlib gtk
```

## Style

Call `plt.style.available` to show options, then set the style of choice.

```python
plt.style.use('seaborn-talk')
```

# Visualizations

Create some dummy data.  

```python
# dummy data
df = pd.DataFrame(data=np.random.rand(24,4),
                  index=pd.date_range(end=pd.datetime.now(), periods=24, freq='MS'),
                  columns=['A', 'B', 'C', 'D'])
```

Visualize categorical time series data.  

```python
# create figure, axes objects
fig, ax = plt.subplots(figsize=(12,8))

# plot
df.plot(ax=ax)

# annotate
ax.set(ylabel='Categories', xlabel='Time', title='Category Volume Over Time')

# format
fig.tight_layout(pad=2)
fig.show()

fig.savefig('category_volume_over_time.png', transparent=False, dpi=300, bbox_inches='tight')
```

![Category Volume Over Time]({{ site.baseurl }}/assets/img/posts/category_volume_over_time.png)  

Group data over time periods. Refer to [Pandas Offset Aliases](http://pandas.pydata.org/pandas-docs/stable/timeseries.html#offset-aliases)  

```python
# sum data per year end
df = df.groupby(pd.TimeGrouper('1A')).sum()
```

Visualize categorical data over grouped time periods.  

```python
# create figure, axes objects
fig, ax = plt.subplots(figsize=(12,8))

# plot
df.plot(kind='bar', ax=ax)

# annotate
ax.set(ylabel='Categories', xlabel='Time', title='Category Volume per Year End')

# auto format postion of xaxis date labels
fig.autofmt_xdate()

# format xaxis date labels
# current bug in pandas doesn't allow the following
# see https://github.com/pandas-dev/pandas/issues/1918
#ax.xaxis_date()
#ax.xaxis.set_major_locator(mpl.dates.YearLocator())
#ax.xaxis.set_major_formatter(mpl.dates.DateFormatter('%d %b %Y'))
# so instead we manually reset in axis labels to our formatted index as series of strings
ax.xaxis.set_major_formatter(plt.FixedFormatter(df.index.to_series().dt.strftime('%d %b %Y')))

# annotate data labels onto vertical bars
# see https://matplotlib.org/users/annotations_guide.html
for bar,(ix,col) in zip(ax.patches, pd.MultiIndex.from_product([df.index, df.columns])):
    ax.annotate(str(round(df.loc[ix,col],2)), xy=(bar.get_x()+.01, bar.get_height()-.5), color='white')

# format
fig.tight_layout(pad=2)
fig.show()

fig.savefig('category_volume_per_year_end.png', transparent=False, dpi=300, bbox_inches='tight')
```

![Category Volume per Year End]({{ site.baseurl }}/assets/img/posts/category_volume_per_year_end.png)  

# Resources

- [Matplotlib docs](https://matplotlib.org/contents.html)  
- [Pandas Visualization docs](https://pandas.pydata.org/pandas-docs/stable/visualization.html)  
- [Seaborn docs](https://seaborn.pydata.org/api.html)  

Chris Moffitt at Practical Business Python has a [great tutorial and helpful infographic](http://pbpython.com/effective-matplotlib.html) on matplotlib  
