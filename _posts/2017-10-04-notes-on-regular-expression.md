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

  - `^` means start at beginning of sting
  - `$` means start from end of string
  - anything in `[]` will return exact matches for those characters
  - anything in `()` means capturing group
  - a non-capturing group is identified by `(?:`+`whatever`+`)`
  - the combination of `(.*?)` will return virtually everything (except for new line)
  - `{4}` means length of 4

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
