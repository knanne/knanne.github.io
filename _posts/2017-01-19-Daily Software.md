---
categories: [technology]
tags: [software]
---

Some notes from my daily software use on Windows 10

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

## Command Console

#### Cmder

Cmder is an attractive and portable console emulator for Windows.

> Cmder is a software package created out of pure frustration over the absence of nice console emulators on Windows. It is based on amazing software, and spiced up with the Monokai color scheme and a custom prompt layout, looking sexy from the start. - [website](http://cmder.net/)  

Notable commands:  

  - summons from taskbar with ``Ctrl + ` ``
  - open a new tab with `Ctrl + Tab`

## Text Editor

#### Atom

Atom is a text editor made by the guys at GitHub so it has some fancy native integrations. Refer to the [Atom Flight Manual](http://flight-manual.atom.io/getting-started/sections/atom-basics/) for basic documentation.

Notable commands:  

  - open a new window with `Ctrl + Shift + N`
  - open a project folder with 'Ctrl + Shift + A'
  - unhide auto-hidden menu with `Alt`  
  - open command palette with `Ctrl + Shift + P`

Packages I use include:  

  - [autocomplete-python](https://atom.io/packages/autocomplete-python)

## Programming

#### Python

[Python](https://www.python.org) is my language of choice for anything from data analysis and manipulation, to web development. The official package manager in Python is called [pip](https://pip.pypa.io/en/stable/)  

Below are a few Python-related and necessary tools.  

###### Anaconda

I recommend also downloading [Anaconda (or Miniconda)](https://www.continuum.io/downloads)  

> Anaconda is the leading open data science platform powered by Python. The open source version of Anaconda is a high performance distribution of Python and R and includes over 100 of the most popular Python, R and Scala packages for data science.

###### Jupyter Notebook

[Jupyter](http://jupyter.org/) (Formerly IpythonNotebook) now supports everything you would ever need for data analysis and visualization, even with interactive charts for some libraries.  

###### Rodeo

[Rodeo](https://www.yhat.com/products/rodeo) is a nice Python IDE, basically RStudio for Python.

> Rodeo is a development environment that’s lightweight and intuitive, yet customizable to its core - your own personal home base for exploring and interpreting data. - [website](https://www.yhat.com/products/rodeo)

###### Virtual Environments for Development

If you are using [Conda](https://conda.io/), there is nice virtual environment functionality built in.  

> With conda, you can create, export, list, remove, and update environments that have different versions of Python and/or packages installed in them. Switching or moving between environments is called activating the environment. You can even share an environment file with a coworker. - [docs](https://conda.io/docs/using/envs.html)

```shell
# create virtual environment
conda create --n snowflakes
# list virtual environments
conda env list
# activate env
activate snowflakes
# deactivate env
deactivate
```

Alternatively, [virtualenvwrapper-win](https://github.com/davidmarble/virtualenvwrapper-win/) is a Windows port of virtualenvwrapper, which is a more intuitive way to create [virtual environments in Python](http://docs.python-guide.org/en/latest/dev/virtualenvs/)  

```shell
# create virtual environment
mkvirtualenv APP
# list virtual environments
lsvirtualenv
# activate env
workon APP
# deactivate env
deactivate
```

## Database

#### DBeaver

[DBeaver](http://dbeaver.jkiss.org/download/) is an open source universal SQL client.

> Free multi-platform database tool for developers, SQL programmers, database administrators and analysts. Supports all popular databases: MySQL, PostgreSQL, SQLite, Oracle, DB2, SQL Server, Sybase, Teradata, MongoDB, Cassandra, Redis, etc. - [website](http://dbeaver.jkiss.org/)

## Internet

#### Chrome

Notable commands:  

  - open new window `Ctrl + N`
  - open new window in incognito mode `Ctrl + Shift + N`
  - open new tab `Ctrl + T`
  - toggle between open tabs `Ctrl + Tab`
  - open developer tools `Ctrl + Shift + J`

Google [source](https://support.google.com/chrome/answer/157179?)  

## OS

#### Windows

Notable commands:  

  - open task view with `Windows + Tab`
    - press `Tab` the arrow keys within task view to toggle between desktops
  - lock the computer with `Windows + L`

Microsoft hotkeys [source](https://support.microsoft.com/en-us/help/12445/windows-keyboard-shortcuts)

If you are using the native cmd console on Windows, the following commands are helpful.

```shell
# dir info  
dir
# show entire tree of subfolders  
tree
# list files and subfolders  
dir /b
# list all files in subfolders  
dir /s
```

###### Windows Bash

Windows 10 now features a full Ubuntu installation, with Linux bash, on top of Windows. Read about it [here.](https://msdn.microsoft.com/en-us/commandline/wsl/about)  

> Bash on Windows provides developers with a familiar Bash shell and Linux environment in which you can run most Linux command-line tools, directly on Windows, UNMODIFIED, without needing an entire Linux virtual machine!

The installation process, is more of [turning it on within Windows developer mode.](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide)  

You may also want to unhide the Ubuntu system after getting it. Do so with `attrib -s -h lxss`. Refer to [this Q&A thread](http://askubuntu.com/questions/759880/where-is-the-ubuntu-file-system-root-directory-in-windows-nt-subsystem-and-vice).

The installation is located at `C:\Users\<USER>\AppData\Local\lxss\`. Be very careful with playing around here, **you can easily corrupt any file simply by opening it in a Windows program.**
