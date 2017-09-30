---
categories: [data analysis]
tags: [python, pandas]
---

A compilation of handy code snippets for transforming data using Pandas  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

This list will hopefully save me time from not having to search Stackoverflow again.

# JSON

From JSON dictionary.  

```python
# dummy json data
d = {}
for i in range(5):
    for j,k in enumerate(np.random.rand(5)):
        d[(i,j)] = {'data1':k, 'data2':np.square(k), 'data3':np.sqrt(k), 'data4':np.log(k)}
```

```python
# create DataFrame from dictionary where keys are DataFrame multiindex
df = pd.DataFrame.from_dict(d, orient='index')
# rename multiindex
df.index.names = ['category1', 'category2']
```

To JSON dictionary.  

```python
df.to_dict()
```

To get back to original format we had, first transpose.  

```python
df.T.to_dict()
```
