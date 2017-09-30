---
categories: [data analysis]
tags: [python, pandas]
---

Helpful scripts for data "munging" data using Pandas  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Header

I often wish to standardize the header of a dataset after import, because the creator used spaces, or other non-alphanumeric characters when naming columns.  

```python
import re
stdz = lambda s: re.sub('[^0-9a-zA-Z]+', '_', s.lower())
df.columns = df.columns.map(stdz)
```

# Impute

Impute all null values in an entire dataframe of numeric data to 0.  

```python
df.fillna(0)
```

If you need to impute more than `NAN` values (maybe because you divided by 0 and now have infinite), you can chain together a `.replace()` and `.fillna()`.  

```python
df.col.replace([-np.inf, np.inf], np.nan).fillna(0)
```

# Coalesce

The concept of applying coalesce to multiple columns (like in SQL) can be applied on dataframe columns. For example if you wanted to set a master phone number for record based on priority of phone1-3, you could do something like the following.  

```python
df.iloc[:,'phone'] = np.nan
df['phone'] = df['phone'].fillna(df.phone1).fillna(df.phone2).fillna(df.phone3)
```

# Dedupe

Dropping duplicates using `df.dropduplicates()` is the simplest method of deduplicating records by far. You can give keyword arguments to make it more useful like a subset of columns.  

However, you are probably always going to want to apply some sort of logic to your method of keeping records, like keep the record with max value (in col4) for each combination of multiple columns (col1, col2,  and col3). Achieve this with the following code, by slicing the your dataframe on indices of max for each group.  

```python
df.iloc[df.groupby(['col1', 'col2', 'col3']).col4.idxmax()]
```

# Filter

Search a column by a list of keywords, for filtering out bad data.  

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
