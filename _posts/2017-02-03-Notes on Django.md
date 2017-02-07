---
layout: post
categories: [tech]
tags: [django, python]
author: Kain Nanne
---

Notes on building a Django app in Python using a cookiecutter

<!-- excerpt separator -->

This post contains my notes while going through the cookiecutter-django [docs](http://cookiecutter-django.readthedocs.io/en/latest/) and the official [django docs](https://docs.djangoproject.com/) simultaneously to setup an app  

**Django**

> Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design. Built by experienced developers, it takes care of much of the hassle of Web development, so you can focus on writing your app without needing to reinvent the wheel. It’s free and open source. - [website](https://github.com/pydanny/cookiecutter-django)

**Cookiecutter Django**

> Powered by Cookiecutter, Cookiecutter Django is a framework for jumpstarting production-ready Django projects quickly. - [website](https://github.com/pydanny/cookiecutter-django)

## initialize a project

assuming you have both django and cookiecutter installed, if not run  

```shell
pip install django
pip install cookiecutter
```

let's assume we created a project called "My App" with a slug "mappy" using the following code    

```shell
cookiecutter https://github.com/pydanny/cookiecutter-django
```

answer the questions of requirements, otherwise hit enter to use defaults  

## setup database

install [postgresql]()  

default user on installation is `postgres`. if you don't specify user with `-U <USER>` it defaults to windows user which is not an actual postgres user  

add the necessary environment variables to `~/mappy/config/settings/.env` (see related [issue #490](https://github.com/pydanny/cookiecutter-django/issues/490))  

<mark>also, make sure this `.env` file is in your `.gitignore`</mark>  

initialize a project database  

```shell
createdb -U postgres mappy
python manage.py migrate
python manage.py createsuperuser
```

you can now run the app using `python manage.py runserver`, navigate to localhost:8000 and login  

## start developing something

create a new `app` within your project  

```shell
python manage.py startapp polls
```

you will now see a new app called polls under `mappy/polls/` with appropriate django tree files  

> What’s the difference between a project and an app? An app is a Web application that does something – e.g., a Weblog system, a database of public records or a simple poll app. A project is a collection of configuration and apps for a particular website. A project can contain multiple apps. An app can be in multiple projects. - [Django docs](https://docs.djangoproject.com/en/1.10/intro/tutorial01/)  

#### configure the new app

now we need to configure our app to work with the rest of this cookiecutter project  

configure the app to the project  

###### `polls/app.py`
```python
class MappyConfig(AppConfig):
    name = 'mappy.polls'
```

configure your new local app in project common  

###### `mappy/config/settings/common.py`
```python
# Your stuff: custom apps go here
'mappy.polls.apps.PollsConfig'
```

add your local app urls to

###### `mappy/config/urls.py`  
```python
# Your stuff: custom urls includes go here
url(r'^polls/', include('mappy.polls.urls', namespace='logs')),
```

#### code your new app

add a base view  

###### `polls/views.py`  
```python
from django.shortcuts import render
from django.http import HttpResponse

def polls(request):
    return HttpResponse("Hello, world. You're at the polls index.")
```

add the corresponding urls for the app  

###### `polls/urls.py`  
```python
from django.conf.urls import url
from . import views

urlpatterns = [
    url(
        regex=r'^$',
        view=views.polls,
        name='polls'
    ),
]
```

add your models

###### `polls/models.py`  
```python
from django.db import models

class Record(models.Model):
    datetime = models.DateTimeField()
    text = models.CharField(max_length=200)
```

configure django-admin to new app    

###### `polls/admin.py`  
```python
from django.contrib import admin
from .models import Record

admin.site.register(Record)
```

update the database with your new models  

```shell
# create migrations for model changes
python manage.py makemigrations
# apply changes to database
python manage.py migrate
```

> Migrations are very powerful and let you change your models over time, as you develop your project, without the need to delete your database or tables and make new ones - it specializes in upgrading your database live, without losing data. - [Django docs](https://docs.djangoproject.com/en/1.10/intro/tutorial02/)  

#### run your new app  

```shell
python manage.py runserver
```

## some helpful commands

delete all data in databases  

```shell
python manage.py flush
```
