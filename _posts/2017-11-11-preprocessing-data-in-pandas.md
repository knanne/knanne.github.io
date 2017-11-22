---
categories: [data analysis]
tags: [python, pandas]
---

Notes on preparing a Pandas DataFrame for statistical modeling

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Pandas

## Scale

Transform all data columns to having range from 0 to 1.  

```python
scale = lambda x: x / x.max()
df_scale = df.apply(scale)
df_scale.describe()
```

## Normalize

Transform all data columns to having mean 0, and standard deviation 1.  

```python
normalize = lambda x: (x - x.mean()) / x.std()
df_norm = df.apply(normalize)
df_norm.describe()
```

## Standardize

First normalize the data, then scale from 0 to 1.  

```python
df_stdz = df.apply(normalize).apply(scale)
# if the above throws an error, this means you probably divided by zero when normalizing. Use the below code to first impute bad data to 0 before scaling.
#df_stdz = df.apply(normalize).replace([-np.inf,np.inf], np.nan).fillna(0).apply(scale)
df_stdz.describe()
```

# scikit-learn

Using [scikit-learn](http://scikit-learn.org/), do the same thing.  

```python
from sklearnsklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()

df_stdz = pd.DataFrame(scaler.fit_transform(df), columns=df.columns, index=df.index)
df_stdz.describe()
```

Now look into other [built-in preprocessors on scikit-learn]((http://scikit-learn.org/stable/modules/preprocessing.html)), and consider [how to handle outliers](http://scikit-learn.org/stable/auto_examples/preprocessing/plot_all_scaling.html#sphx-glr-auto-examples-preprocessing-plot-all-scaling-py)
