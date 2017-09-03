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
import seaborn as sns
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

And customize the style sheet manually using `rcParams`  

See more on styling here: [matplotlib.org/users/customizing](https://matplotlib.org/users/customizing.html)  

```python
plt.style.use('seaborn-white')

mpl.rc('figure')
mpl.rc('savefig', transparent=True, dpi=700, bbox='tight', pad_inches=.05, format='png')
```

# Data

```
df = pd.DataFrame(data=np.random.rand(36,4),
                  index=pd.date_range(end=pd.datetime.now(), periods=36, freq='MS'),
                  columns=['A', 'B', 'C', 'D'])
```

## Transform

Group data over time periods. Refer to [Pandas Offset Aliases](http://pandas.pydata.org/pandas-docs/stable/timeseries.html#offset-aliases)  

```
dfA = df.groupby(pd.TimeGrouper('1A')).sum()
dfM = df.groupby(pd.TimeGrouper('6M')).sum()
```

# Visualizations

Below are a few examples of basic plots, and simple code on how to use other features like formatting axis and adding labels.  

## Plot Categorical Data Over Time  

```python
fig, ax = plt.subplots(figsize=(12,8))

dfM.plot(ax=ax)

ax.set(ylabel='Categories', xlabel='Time', title='Category Volume Over Time')

for series in dfM.columns:
    for x,y in zip(dfM.index, dfM[series]):
        ax.annotate(str(round(y,2)),
                    xy=(x,y+(.01*dfM.values.max())),
                    fontsize=10, color='grey')

fig.tight_layout(pad=2)
fig.show()

fig.savefig('category_volume_over_time.png')
```

![Category Volume Over Time]({{ site.baseurl }}/assets/img/posts/category_volume_over_time.svg)  

## Plot Categorical Data Over Time Groups

```python
fig, ax = plt.subplots(figsize=(12,8))

dfA.plot(kind='bar', ax=ax)

ax.set(ylabel='Categories', xlabel='Time', title='Category Volume per Year End')

# auto format xaxis labels as date
fig.autofmt_xdate()

# custom format xaxis date labels
# current bug in pandas doesn't allow the following (https://github.com/pandas-dev/pandas/issues/1918)
#ax.xaxis_date()
#ax.xaxis.set_major_locator(mpl.dates.YearLocator())
#ax.xaxis.set_major_formatter(mpl.dates.DateFormatter('%d %b %Y'))
# so instead we manually set xaxis labels to our custom formatted df index as series of strings
ax.xaxis.set_major_formatter(plt.FixedFormatter(dfA.index.to_series().dt.strftime('%b %Y')))

# annotate data labels onto vertical bars
# see https://matplotlib.org/users/annotations_guide.html
for bar,(col,ix) in zip(ax.patches, pd.MultiIndex.from_product([dfA.columns,dfA.index])):
    ax.annotate(str(round(dfA.loc[ix,col],2)),
                xy=(bar.get_x()+(bar.get_width()*.05), bar.get_height()-(dfA.values.max()*.05)),
                fontsize=10, color='white')

fig.tight_layout(pad=2)
fig.show()

fig.savefig('category_volume_per_year_end.png')
```

![Category Volume per Year End]({{ site.baseurl }}/assets/img/posts/category_volume_per_year_end.svg)  

## Scatterplot Matrix

```python
plot = sns.pairplot(df)
plot.savefig('scatterplot_matrix')
```

![Scatterplot Matrix]({{ site.baseurl }}/assets/img/posts/scatterplot_matrix.svg)  

## KDE Plot

```python
plot = sns.jointplot(x="B", y="A", data=df, kind='kde')
plot.savefig('kde_plot')
```

![KDE Plot]({{ site.baseurl }}/assets/img/posts/kde_plot.svg)  

# Resources

- [Matplotlib docs](https://matplotlib.org/contents.html)  
- [Pandas Visualization docs](https://pandas.pydata.org/pandas-docs/stable/visualization.html)  
- [Seaborn docs](https://seaborn.pydata.org/api.html) and [Seaborn Tutorials](https://seaborn.pydata.org/tutorial.html#tutorial)  

Chris Moffitt at Practical Business Python has a [great tutorial and helpful infographic](http://pbpython.com/effective-matplotlib.html) on matplotlib  
