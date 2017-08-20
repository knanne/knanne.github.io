---
categories: [data analysis]
tags: [python, pandas]
---

A compilation of handy code snippets  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Introduction

This list will hopefully save me time from not having to search stackoverflow again.

# Strings

Filter dataframe on text column, by list of keys

```Python
# create dataframe with some text field
df = pd.DataFrame({'text' : ['somekey1blah',
                             'somekey2blah',
                             'somekey3blah',
                             'somekey4blah',
                             'somekey5blah']})

# identify keys in your text field
keywords = ['key1', 'key2', 'key3']

# perform lookup of keys in text field
# exclude these rows from dataframe
df = df[(df['text'].str.contains('|'.join(keywords), case=False)) == False]
```
