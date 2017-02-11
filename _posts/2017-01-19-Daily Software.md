---
layout: post
categories: [tech]
tags: [software]
author: Kain Nanne
---

Some notes from my daily software use on Windows 10

<!-- excerpt separator -->

## Cmder

> Cmder is a software package created out of pure frustration over the absence of nice console emulators on Windows. It is based on amazing software, and spiced up with the Monokai color scheme and a custom prompt layout, looking sexy from the start.
> - [download it](http://cmder.net/)  

Notable commands:
  - summons from taskbar with ``Ctrl + ` ``
  - open a new tab with `Ctrl + Tab`

## Atom

Atom is a text editor made by the guys at GitHub so it has some fancy native integrations. Refer to the [Atom Flight Manual](http://flight-manual.atom.io/getting-started/sections/atom-basics/) for basic documentation.

Notable commands:
  - open a new window with `Ctrl + Shift + N`
  - open a project folder with 'Ctrl + Shift + A'
  - unhide auto-hidden menu with `Alt`  
  - open command palette with `Ctrl + Shift + P`

Packages I use include:  
  - [autocomplete-python](https://atom.io/packages/autocomplete-python)

## Python for Data Analysis

#### Jupyter Notebook

[Jupyter](http://jupyter.org/) (Formerly IpythonNotebook) now supports everything you would ever need for data analysis and visualization, even with interactive charts for some libraries.  

#### Rodeo

[Rodeo](https://www.yhat.com/products/rodeo) is basically RStudio, but of course for Python. Which means it's pretty dope.  

#### Virtual Envrionments

[virtualenvwrapper-win](https://github.com/davidmarble/virtualenvwrapper-win/) is a Windows port of virtualenvwrapper, which is a more intuitive way to create [virtual environments in Python](http://docs.python-guide.org/en/latest/dev/virtualenvs/)  

```shell
# create virtual environment
mkvirtualenv APP
# activate env
workon APP
# deactivate env
deactivate
```

## Chrome

Notable commands:  
  - open new window 'Ctrl + N'
  - open new window in incognito mode 'Ctrl + Shift + N'
  - open new tab 'Ctrl + T'
  - toggle between open tabs `Ctrl + Tab`
  - open developer tools `Ctrl + Shift + J`

Google [source](https://support.google.com/chrome/answer/157179?)  

## Windows

Notable commands:  
  - open task view with `Windows + Tab`
    - press `Tab` the arrow keys within task view to toggle between desktops
  -  lock the computer with `Windows + L`

Microsoft [source](https://support.microsoft.com/en-us/help/12445/windows-keyboard-shortcuts)
