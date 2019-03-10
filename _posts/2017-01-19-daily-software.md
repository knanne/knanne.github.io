---
categories: [technology]
tags: [software]
---

Some notes on the software I use on a daily basis for work, on Windows 10

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Command Console

## Cmder

Cmder is an attractive and portable console emulator for Windows.  

> Cmder is a software package created out of pure frustration over the absence of nice console emulators on Windows. It is based on amazing software, and spiced up with the Monokai color scheme and a custom prompt layout, looking sexy from the start. - [website](http://cmder.net/)  

Notable Commands:  
  - open a new tab with `Ctrl + Tab`  

Notable (Linux) Shell Commands:

```shell
# run a program (global .exe)
atom
```

# Text Editor

## Notepad++

[Notepad++] is a super simple text editor, but so useful.  

> Notepad++ is a free (as in "free speech" and also as in "free beer") source code editor and Notepad replacement that supports several languages - [website](https://notepad-plus-plus.org/)

Common cases I use it for:  
  - quickly edit many lines at once using `Alt + Select Drag`
  - convert encoding of a file with `Encoding > Convert to ...`
  - view special characters by turning on `View > Show All Characters`
  - convert Tabs to Spaces with `Edit > Blank Operations > Tab to Space`

Notable Commands:
  - go to line in file with `Ctrl + G`  

## Atom

Atom is a text editor made by the guys at GitHub so it has some fancy native integrations. Refer to the [Atom Flight Manual](http://flight-manual.atom.io/getting-started/sections/atom-basics/) for basic documentation.

> Atom is a text editor that's modern, approachable, yet hackable to the core—a tool you can customize to do anything but also use productively without ever touching a config file. - [website](https://atom.io/)

Notable Commands:  
  - open a new window with `Ctrl + Shift + N`  
  - open a project folder with `Ctrl + Shift + A`  
  - unhide auto-hidden menu with `Alt`  
  - open command palette with `Ctrl + Shift + P`  
  - go to line in file with `Ctrl + G`  

Installing Packages:  

```shell
apm install editorconfig
```

Alternatively, Go to `Settings > Install > Search`  

Packages I use include:  
  - [autocomplete-python](https://atom.io/packages/autocomplete-python)
  - [editorconfig](https://atom.io/packages/editorconfig)
  - [multi-cursor](https://atom.io/packages/multi-cursor)

# Programming

## Python

[Python](https://www.python.org) is my language of choice for anything from data analysis and manipulation, to web development. The official package manager in Python is called [pip](https://pip.pypa.io/en/stable/).  

Install most python packages with `pip install <PACKAGE>`, update most python packages with `pip install <PACKAGE> --upgrade`. If you have multiple versions of python/pip or are running into permissions errors on Windows, use syntax `python -m pip install <PACKAGE>` which ensures you run the command from global Python executable.  

Below are notes on a few other useful tools for Python.  

### Anaconda

I recommend downloading Python thru [Anacondo](https://www.continuum.io/downloads) which comes with various data science libraries out of the box.  

> Anaconda is the leading open data science platform powered by Python. The open source version of Anaconda is a high performance distribution of Python and R and includes over 100 of the most popular Python, R and Scala packages for data science.

To keep updated, use the following commands.  

```shell
conda update python
conda update anaconda
```

Installing and updating libraries with Anaconda package manager (instead of pip) is just `conda install <PACKAGE>` and `conda update <PACKAGE>`  

### Jupyter

[Jupyter Notebook](http://jupyter.org/) (Formerly IpythonNotebook) now supports everything you would ever need for data analysis and visualization, even with interactive charts for some libraries. Read the docs at [jupyter-notebook.readthedocs.io](http://jupyter-notebook.readthedocs.io/en/stable/notebook.html).  

More recently, there is now a [Jupyter Lab](http://jupyterlab.readthedocs.io/en/stable/index.html) which combines Jupyter Notebook with other helpful data science related features. Read [this blog post release](https://blog.jupyter.org/jupyterlab-is-ready-for-users-5a6f039b8906) for more on Jupyter Lab. FYI, it has a [fantastic interface](https://jupyterlab.readthedocs.io/en/stable/user/interface.html) for all data science-related work.  

If you have multiple python versions (virtual environments), you can toggle which kernel to use from within Jupyter Notebook using the libary `ipykernel`.  

To make a conda environment in Jupyter, use the below commands as per [ipython docs here](https://ipython.readthedocs.io/en/stable/install/kernel_install.html#kernels-for-different-environments)  

```shell
activate project-env
python -m ipykernel install --user --name myenv --display-name "Project Env"
```

### Virtual Environments for Development

If you are using [Conda](https://conda.io/), there is nice virtual environment functionality built in.  

> With conda, you can create, export, list, remove, and update environments that have different versions of Python and/or packages installed in them. Switching or moving between environments is called activating the environment. You can even share an environment file with a coworker. - [docs](https://conda.io/docs/using/envs.html)

```shell
# create virtual environment
conda create -n py27 python=2.7
# list virtual environments
conda env list
# activate env
activate py27
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

### Documentation

Always document your code. A good library for a reference is [Pandas](http://pandas.pydata.org/pandas-docs/stable/), which actually uses [NumPy/SciPy documentation standard](https://github.com/numpy/numpy/blob/master/doc/HOWTO_DOCUMENT.rst.txt).  

Python Enhancement Proposals (PEP) are standards to follow for writing Python code. For example, use [PEP 8](https://www.python.org/dev/peps/pep-0008/) as a Style Guide for Python, and [PEP 257](https://www.python.org/dev/peps/pep-0257/) for Docstring Conventions.  

Use [flake8](http://flake8.pycqa.org/en/latest/) to adhere to above conventions.  

When writing and publishing software, a recommended route to use build you documentation using [Sphinx](http://www.sphinx-doc.org/en/stable/), and host on [Read The Docs](https://docs.readthedocs.io/en/latest/index.html).  

# ETL Workflow Automation

[KNIME](https://www.knime.com/knime-analytics-platform) is an open source software for creating data science workflows without programming.  

KNIME is designed for drag-and-drop people, however it provides a really efficient way to automate data pipelines by combining programming (python) nodes, with their quickform nodes to create simple WebApps to run from the browser.  

# Database

Setup a local instance of [MySQL](https://dev.mysql.com/downloads/installer/)  

Setup a local instance of [PostgreSQL](https://www.postgresql.org/download/)  

## DBeaver

[DBeaver](http://dbeaver.jkiss.org/download/) is an open source universal SQL client.

> Free multi-platform database tool for developers, SQL programmers, database administrators and analysts. Supports all popular databases: MySQL, PostgreSQL, SQLite, Oracle, DB2, SQL Server, Sybase, Teradata, MongoDB, Cassandra, Redis, etc. - [website](http://dbeaver.jkiss.org/)  

# Internet

## Google Services

I use basically all google services, because I have always been a fan of Android. However, I am also a fan of keeping Windows. So here are some tips on integrating the two.  

- in Windows 10, add your Google account to either "Mail", "Calendar", or "People" as these are actually all the same, and you will receive all your mail, calendar, and contacts from Google natively in the Windows notification center.
- download [Google Drive](https://www.google.com/drive/download/), and setup Backup and Sync. Your Google Photos will be automatically synced as well, as long as you have the sync on from your phone.
- in Google Chrome, navigate to a Google service of choice (e.g. keep.google.com, news.google.com, voice.google.com, hangouts.google.com, photos.google.com etc.), then go to `Menu > More tools > Add to desktop` and make sure `Open as new window` is checked  

## Chrome

Notable commands:  

  - open new window `Ctrl + N`
  - open new window in incognito mode `Ctrl + Shift + N`
  - open new tab `Ctrl + T`
  - toggle between open tabs `Ctrl + Tab`
  - open developer tools `Ctrl + Shift + J`

Google [source](https://support.google.com/chrome/answer/157179?)  

# OS

## Windows

Notable Commands:  

  - switch between open apps with `Alt + Tab`
  - open task view with `Windows + Tab`
    - press `Tab` the arrow keys within task view to toggle between desktops
  - cycle through apps on the taskbar with `Windows + T`
  - lock the computer with `Windows + L`
  - add a virtual desktop with `Windows + Ctrl + D`
  - switch between virtual desktops with `Windows + Ctrl + Arrow Key`

Weird Commands:  

  - `Ctrl`+`Alt`+`Down` flips screen content upside down

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
# run a program (global .exe)
start atom
```

### Windows Bash

Windows 10 now features a full Ubuntu installation, with a Linux bash for running ELF binaries, on top of Windows. Read about it [here.](https://msdn.microsoft.com/en-us/commandline/wsl/about)  

> Bash on Windows provides developers with a familiar Bash shell and Linux environment in which you can run most Linux command-line tools, directly on Windows, UNMODIFIED, without needing an entire Linux virtual machine!

The installation process, is more of [turning it on within Windows developer mode.](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide)  

You may also want to unhide the Ubuntu system after getting it. Do so with `attrib -s -h lxss`. Refer to [this Q&A thread](http://askubuntu.com/questions/759880/where-is-the-ubuntu-file-system-root-directory-in-windows-nt-subsystem-and-vice).

The installation is located at `C:\Users\<USER>\AppData\Local\lxss\`. Be very careful with playing around here, **you can easily corrupt any file simply by opening it in a Windows program.**

### Hyper-V

Latest versions of Windows comes with a feature that allows you to build and run virtual machines. This can be super handy for those wishing to run Linux. Read more about it [here](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/)  
