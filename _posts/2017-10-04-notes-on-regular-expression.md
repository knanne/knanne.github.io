---
categories: [data analysis]
tags: [regex]
---

Notes and scripts on Regular Expression that may be useful to others

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Intro

Regular Expression is some serious magic.  

But, after some time playing around at [regex101.com/](https://regex101.com/), you can understand how to combine the right components you may need to solve your problems.  

# Basics

Here is a short list of some common regex code and their meanings.  

  - `^` means start at beginning of sting
  - `$` means start from end of string
  - anything in `[]` will return exact matches for those characters
  - adding a `^` inside the square brackets negates those characters, and returns anything but the given characters, for example: `[^0-9]` will return non-numeric characters  
  - anything in `()` means capturing group
  - a non-capturing group is identified by `(?:`+`whatever`+`)`
  - the combination of `(.*?)` will return virtually everything (except for new line)
  - chain logic together with logical OR using pipe operator `|`
  - `{4}` following a pattern means with length of 4
  - `\b` will match a "word boundary"
  - `(?=)` is used as a "positive look ahead", see [this simple explanation](https://stackoverflow.com/a/2973495/5356898)
  - `(?<=)` is used as a "positive look behind", see [this simple explanation](https://stackoverflow.com/a/2973495/5356898)

# Validation

A good use for regular expression is for validation strings. For example, if you manage some user interface where you want to accept input based on some set criteria.  

## Comma Separated Words

The following will validate only a list of comma separated characters (lowercase, or uppercase).  

`^([a-zA-Z ])+(,[a-zA-Z ]+)*$`

## Comma Separated Numbers

The following will validate a only list of comma separated numbers of length 1 to 10.  

`^([0-9]{1,10})+(,[0-9]{1,10}+)*$`  

## Email

If we consider an email con only contain characters `0-9`, `a-z`, `A-Z`, `-`, `.`, or `_`, we can construct checks for these characters separated by `@`.  

Verify string is email with `^([0-9a-zA-Z._-]+)@(?:[0-9a-zA-Z._-]*)$`.  

Verify string is a list of emails, separated by comma or semicolon, with `^(([0-9a-zA-Z._-]+)@(?:[0-9a-zA-Z._-]*)(\]?)(\s*(;|,)\s*|\s*$))*$`.  

To achieve both of these and also check for a specific email domain, for example a company email address, use `^([0-9a-zA-Z._-]+)@company.com$`  

Or for a comma / semicolon separated list `^(([0-9a-zA-Z._-]+)@company.com(\]?)(\s*(;|,)\s*|\s*$))*$`  

# Search

Regular expression can have many applications in data analysis for searching text data.  

## Between

Just use `prefix(.*?)suffix`.  

Or combine the above logic with non-capturing groups for more dynamic searching. For example, `(?:prefix1|prefix2|prefix3)(.*)(?:suffix1|suffix2|suffix3)`  

Imagine if you needed to parse contracts or some sort of somewhat standardized document to find optional data fields. You could construct a regular expression to include the possible words that would always appear before and after the desired text (e.g. "party 1 paid...to party 2").  

# Python

Here is a, not very practical example, of how to use regular expression in python.  

The regular expression: `(?:slow|quick)(.*)(?:walks|jumps|crawls)(.*)(?:lazy|happy|sleeping)(.*)`  

The example text:  
> The quick brown fox jumps over the lazy dog  

```python
import re

s = "The quick brown fox jumps over the lazy dog."

pattern = "(?:slow|quick)(.*)(?:walks|jumps|crawls)(.*)(?:lazy|happy|sleeping)(.*)"

r = re.findall(pattern, s)

print(r)
```

This will print out: `[(' brown fox ', ' over the ', ' dog.')]`  

# Find and Replace

Another common problem to solve may be finding and replacing certain text, using more complicated logic than the traditional method.  

## Replace Leading or Trailing Characters

Instead of doing a find and replace of an extract string, regex allows you create a logical search for certain characters based on their position in relation to other characters.  

For example, imagine the case of have the string `"$ 10,000.00 USD"`, and we want to remove the leading or trailing non-numeric characters and keep only the numeric characters, as this is the valid data we want to store.  

Use the positive look ahead/behind concepts in regex to apply the following logic.  

`^[^0-9 ]+(?=[0-9,\.])` will match leading non-numeric characters preceding a pattern of numeric characters which may also include comma or period  

`(?<=[0-9,\.])[^0-9]+$` will similarly match the trailing non-numeric following a pattern of numeric characters which may also include comma or period  

Wrapping this up in Python, with the `re.sub()` function looks like:  

```python
s = "$ 10,000.00 USD"
print(s)
s = re.sub(r'^[^0-9]+(?=[0-9,\.])','',s)
print(s)
s = re.sub(r'(?<=[0-9,\.])[^0-9]+$','',s)
print(s)
```

# Random Code Snippets

## Clean Date Text

Here is a simple implementation of cleaning date text, from [this StackOverflow post and answer](https://stackoverflow.com/a/14478473/5356898)  

Imagine parsing text with a date that looks like: "24th of April, 2018". Wish there was a way to identify these number endings to remove them? Enter `(?<=\d)(st|nd|rd|th)\b`.  

By adding more logic or chaining other cleaning methods in python, you could try and capture many once dirty date text chunks into datetimes types.  

```python
import pandas as pd
import re

s = "24th of April, 2018"
s = re.sub(r"(?<=\d)(st|nd|rd|th)\b", '', s)
s = ' '.join(s.replace(',','').replace('of','').split())
d = pd.to_datetime(s, infer_datetime_format=True)
d
```

This will result in:  

```python
Timestamp('2018-04-24 00:00:00')`
```
