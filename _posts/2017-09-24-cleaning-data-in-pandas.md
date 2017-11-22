---
categories: [data analysis]
tags: [python, pandas]
---

Helpful scripts for data "munging" data using Pandas  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Columns

I often wish to standardize the header of a dataset after import, because the creator used capital letters, spaces, or other non-alphanumeric characters when naming columns.  

```python
import re
clean = lambda s: re.sub('[^0-9a-zA-Z]+', '_', s.lower())
df.columns = df.columns.map(clean)
```

# Missing Data

Count how many non-`NULL` values are in each column.  

```python
df.count()
```

A fast and effective way to count how many `NULL` values are in each column.  

```python
df.isnull().sum()
```

Impute all `NULL` values in an entire DataFrame of numeric data to 0.  

```python
df.fillna(0)
```

If you need to impute more than `NULL` values (maybe because you divided by 0 and now have infinite), you can chain together a `.replace()` and `.fillna()`.  

```python
df.col.replace([-np.inf, np.inf], np.nan).fillna(0)
```

# Coalesce

The concept of applying coalesce to multiple columns (like in SQL) can be applied on DataFrame columns. For example if you wanted to set a master phone number for record based on priority of phone1-3, you could do something like the following.  

```python
df.iloc[:,'phone'] = np.nan
df['phone'] = df['phone'].fillna(df.phone1).fillna(df.phone2).fillna(df.phone3)
```

# Dedupe

Dropping duplicates using `df.dropduplicates()` is the simplest method of deduplicating records by far. You can give keyword arguments to make it more useful like a subset of columns.  

However, you are probably always going to want to apply some sort of logic to your method of keeping records, like keep the record with max value (in col4) for each combination of multiple columns (col1, col2, and col3). Achieve this with the following code, by slicing the your DataFrame on indices of max for each group.  

```python
df.iloc[df.groupby(['col1', 'col2', 'col3']).col4.idxmax()]
```

# Search

Search a column by a regular expression pattern, or single keyword, with `.str.contains()` or `.str.match()`. For more on this, refer to the Pandas docs on [working with text data](https://pandas.pydata.org/pandas-docs/stable/text.html#testing-for-strings-that-match-or-contain-a-pattern). Alternatively, filter on a list of keywords with the below code.  

```python
df = pd.DataFrame({'text' : ['somekey1blah',
                             'somekey2blah',
                             'somekey3blah',
                             'somekey4blah',
                             'somekey5blah']})

keywords = ['key1', 'key2', 'key3']

# inclusive search
df[df['text'].str.contains('|'.join(keywords), case=False)]
# exclusive search
df[df['text'].str.contains('|'.join(keywords), case=False) == False]
```

# Explode

```python
df = pd.DataFrame({'csv' : ['value1',
                             'value1,value2',
                             'value1,value2,value3,value4,value5,value6',
                             'value1',
                             'value1,value2,value3,value14']})

df_exploded = df['csv'].str.split(pat=',', expand=True).stack().to_frame()

df_exploded.columns = ['value']
df_exploded.index.names = ['id', 'sequence']

df_exploded = df_exploded.reset_index(level='sequence')

df = df.merge(df_exploded, how='left', left_index=True, right_index=True)
```
