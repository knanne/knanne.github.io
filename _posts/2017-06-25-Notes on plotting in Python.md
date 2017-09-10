---
categories: [data visualization]
tags: [python, pandas, matplotlib, jupyter]
---

Helpful scripts and samples for plotting in Python

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Setup

[Pandas](https://pandas.pydata.org/) is a common one stop shop for everything data analysis in python. Most plotting can be done using `df.plot()` syntax, however, you must import [Matplotlib](https://matplotlib.org/index.html) since this is a dependency. I would also recommend installing [Seaborn](https://seaborn.pydata.org/) for more interesting plot types and statistical features. Plus it has a nice native style.  

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

Couple options for visualizing in a Jupyter Notebook. Either present static charts `inline`, embed them as interactive elements using `notebook` setting, or open the chart in a new windows using a specified backend (e.g. `GTK3Agg` for raster graphics, `GTK3Cairo` for vector graphics). [ipython source](http://ipython.readthedocs.io/en/stable/interactive/plotting.html) (somewhat out of date), [matplotlib source](https://matplotlib.org/faq/usage_faq.html#what-is-a-backend) BTW, [here](https://matplotlib.org/faq/howto_faq.html#howto-webapp) is info on how to run matplotlib in backend of webserver.  

```python
%matplotlib inline
#%matplotlib notebook
#%matplotlib GTK3Cairo
```

It is recommended to import pyplot after configuring matplotlib

```python
from matplotlib import pyplot as plt
```

## Style

Call `plt.style.available` to show options, then set the style of choice.  

And customize the style sheet manually using `rcParams`. Below I customize how the plot is exported using `fig.savefig()` command.  

See more on styling here: [matplotlib.org/users/customizing](https://matplotlib.org/users/customizing.html)  

```python
plt.style.use('seaborn-white')
mpl.rc('savefig', transparent=True, dpi=700, bbox='tight', pad_inches=.05, format='png')
```

For colors, there are endless presets in matplotlib or seaborn. But, you can always construct your own custom length arrays of hues. Below is a sample from [colorbrewer](http://colorbrewer2.org)  

```
colors = [
    '#8dd3c7',
    '#ffffb3',
    '#bebada',
    '#fb8072',
    '#80b1d3'
]
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
```

![Category Volume Over Time]({{ site.baseurl }}/assets/img/posts/category_volume_over_time.svg)  

## Plot Categorical Data Over Time Groups

```python
fig, ax = plt.subplots(figsize=(12,8))

dfA.plot(kind='bar', ax=ax)

ax.set(ylabel='Volume', xlabel='Time', title='Category Volume per Year End')

fig.autofmt_xdate()

ax.set_xticklabels(dfA.index.strftime('%b %Y'))

# data labels
for bar,(col,ix) in zip(ax.patches, pd.MultiIndex.from_product([dfA.columns,dfA.index])):
    label = '{:,.2f}'.format(dfA.loc[ix,col])
    ax.text(s=label, x=bar.get_x()+(bar.get_width()/2), y=ba r.get_height()-(.05*bar.get_height()), ha='center', va='top', fontdict={'fontsize':10, 'color':'white'})

fig.tight_layout(pad=2)
fig.show()
```

![Category Volume per Year End]({{ site.baseurl }}/assets/img/posts/category_volume_per_year_end.svg)  

## Build Fully Customizable Plot From Scratch

```python
fig, ax = plt.subplots(figsize=(12,8))

series = len(dfA.columns)
groups = len(dfA.index)
bars = series * groups
width = .90 / series
bar_offset = series * width / 2

# bars
for i,(col,values) in enumerate(dfA.iteritems()):
    s = dfA.columns.get_loc(col) + 1
    rect = ax.bar(np.arange(groups)+(s*width)-bar_offset, list(values), width=width, color=colors[i])

ax.set_xticks(np.arange(groups)+width)
ax.set_xticklabels(dfA.index.strftime('%b %Y'))
fig.autofmt_xdate()

ax.tick_params(axis='both', which='both', direction='out', length=6, width=2,
               left='on', right='off', top='off', bottom='on',
               labelsize=12)

ax.set(ylabel='Volume', xlabel='Time', title='Category Volume per Year End')

# data labels
for bar,(col,ix) in zip(ax.patches, pd.MultiIndex.from_product([dfA.columns,dfA.index])):
    label = '{:,.2f}'.format(dfA.loc[ix,col])
    ax.text(s=label, x=bar.get_x()+(bar.get_width()/2), y=bar.get_height()+(.05*dfA.values.max()), ha='center', va='bottom', fontdict={'fontsize':10})

# legend
handles, labels = ax.containers, list(dfA.columns)
lgd = ax.legend(handles, labels, loc='upper center', bbox_to_anchor=(0.5, -0.15), ncol=4, fontsize=12, frameon=False)
#lgd = ax.legend(handles, labels, loc='lower center', bbox_to_anchor=(0,1.02,1,0.2), ncol=4, fontsize=12, frameon=False)

# remove right and left figure border
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)

fig = plt.gcf()
fig.tight_layout()
fig.subplots_adjust(top=.9, bottom=.2)
fig.show()
```

![Category Volume per Year End Custom]({{ site.baseurl }}/assets/img/posts/category_volume_per_year_end_custom.svg)  

## Scatterplot Matrix

```python
plot = sns.pairplot(df)
```

![Scatterplot Matrix]({{ site.baseurl }}/assets/img/posts/scatterplot_matrix.svg)  

## KDE Plot

```python
plot = sns.jointplot(x="B", y="A", data=df, kind='kde')
```

![KDE Plot]({{ site.baseurl }}/assets/img/posts/kde_plot.svg)  

# Resources

- [Matplotlib docs](https://matplotlib.org/contents.html)  
- [Pandas Visualization docs](https://pandas.pydata.org/pandas-docs/stable/visualization.html)  
- [Seaborn docs](https://seaborn.pydata.org/api.html) and [Seaborn Tutorials](https://seaborn.pydata.org/tutorial.html#tutorial)  

Chris Moffitt at Practical Business Python has a [great tutorial and helpful infographic](http://pbpython.com/effective-matplotlib.html) on matplotlib  
