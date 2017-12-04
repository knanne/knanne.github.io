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

But, after some time playing around at [regex101.com/](https://regex101.com/) it is actually starting to make some sense.  

# Basics

  - `^` means start at beginning of sting
  - `$` means start from end of string
  - anything in `[]` will return exact matches for those characters
  - anything in `()` means capturing group
  - a non-capturing group is identified by `(?:`+`whatever`+`)`
  - the combination of `(.*?)` will return virtually everything (except for new line)

# Email

If we consider an email con only contain characters `0-9`, `a-z`, `A-Z`, `-`, `.`, or `_`, we can construct checks for these characters separated by `@`.  

Verify string is email with `^([0-9a-zA-Z._-]+)@(?:[0-9a-zA-Z._-]*)$`.  

Verify string is a list of emails, separated by comma or semicolon, with `^(([0-9a-zA-Z._-]+)@(?:[0-9a-zA-Z._-]*)(\]?)(\s*(;|,)\s*|\s*$))*$`.  

To achieve both of these and also check for a specific email domain, for example a company email address, use `^([0-9a-zA-Z._-]+)@company.com$`  

Or for a comma / semicolon separated list `^(([0-9a-zA-Z._-]+)@company.com(\]?)(\s*(;|,)\s*|\s*$))*$`  

# Search

## Between

Just use `prefix(.*?)suffix`.  
