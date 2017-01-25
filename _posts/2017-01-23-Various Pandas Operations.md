---
layout: post
categories: [tech]
tags: [python, pandas]
author: Kain Nanne
---

Saving some handy code snippets so I don't have to search stackoverflow every time

<!-- excerpt separator -->

###### Filter dataframe on list of string keys in text column
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
