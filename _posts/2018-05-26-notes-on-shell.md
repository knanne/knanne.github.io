---
categories: [data engineering]
tags: [shell, unix, bash]
---

Random notes on the Unix command line (e.g. bash)

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Intro

The following is a compilation of commands and notes on using the command line. Specifically `bash`. Bash commands, or the corresponding ELF executables, are available on Linux/Unix based systems like Ubuntu and Mac OSX.

While they are not easily available on Windows, it is possible to run some commands via [console emulators like Cmder with Git Bash](http://cmder.net/), or more recently the [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) which gives full access to ELF binaries.  

For an introduction on the command line, there is a great practical book by Jeroen Janssens called Data Science at the Command Line, which can be read online [here](https://www.datascienceatthecommandline.com/).  

Generally speaking, the notes provided here are practical data science examples on the collection of tools exposed via the Unix command line (i.e. bash, shell, console). This can include the defaults or commonly used extensions.  

# Advantages

Unix commands execute specific scripts or tools which have been designed to do a single task, and do it as efficiently as possible without loading all the data in memory. In this case, if available, it is much faster to read/manipulate/process data using these tools than trying to do the same thing in another programming language.  

# Commands

Below is just a short list of notable commands I have found useful, and want to remember. On all commands, use `--help` flag for more info and usage instructions.  

- `echo` writes to output
- `printf` prints with formatting
- `touch` creates an empty file (this command will NOT overwrite or delete contents of an existing file)
- `>` also known as redirect, outputs text to a file, creating it if it does not exist. `>` will overwrite an existing file, while `>>` will append to an existing file
- `head` preview first 10 lines of file
- `sort` sort a file
- `grep` search a file for a regular expression pattern.
- `|` also known as pipe operator, combines multiple commands
- `find` will find a file
- `cat` will concatenate files or output
- `truncate` with `-s 0` option will delete contents of a file
- `uniq` will deduplicate data, however the duplicates must be adjacent (use `sort` first). Use flag `-c` to count the number of duplications. Also pass `-d` flag to show duplicated data only.
- `wc` command on a file by default will return the number of lines, words, and characters.

## Text Editors

### Nano

`nano file.txt`  

Save a file with `Ctrl`+`o`, exit a file with `Ctrl`+`x`  

## For Loops

A one line for loop looks like `for i in {1..10}; do echo "Hello World!"; done`

## Examples

### Basic File Manipulation

The is an example of how to use practical commands in sequence to explore file operations. Run the one by one in order.  

```shell
echo Hello World!

touch data.txt

for i in {1..10}
do
  echo "$i Hello World!" >> data.txt
done

head data.txt

sort data.txt -r

grep [3-7] data.txt

for i in {1..15}; do echo "$i Hello World!" >> data.txt; done

wc data.txt

sort data.txt | uniq -c
```

## Curl

> curl is used in command lines or scripts to transfer data. - [website](https://curl.haxx.se/)

## jq

> jq is a lightweight and flexible command-line JSON processor. - [website](https://stedolan.github.io/jq/)

You may need to download it [here](https://stedolan.github.io/jq/download/)

Here is an example of how to get the `html` key from a returned JSON object, using the open [Instagram oembed endpoint](https://www.instagram.com/developer/embedding/#oembed) for one of my posts.  

```shell
curl -s "https://api.instagram.com/oembed/?url=http://instagr.am/p/BjPSQKJFUYa" | jq -r ".html"
```

# Scripting

`.sh` shell scripts can be used for absolutely anything.  

## Example curl API, redirect JSON key to file

This below is an example of writing a shell script to automatically and dynamically redirect API data to a file in one command.  

### Fetch Latest Instagram Post Embed HTML

I recently created a very simple shell script to fulfill a very simple task for this website.  

My problem was I wanted to embed my latest Instagram post on the [about page](https://knanne.github.io/about/), yet Instagram does not allow to get this dynamically. In this case I have to manually update the embed html for the latest post of interest. This is a hassle, and like any good developer I considered how to automate this.  

After finding that Instagram has an open API for getting a posts embed html, it is possible to simply make a GET request, and parse the HTML from the returned JSON. So I explored using `curl` to do the HTTP request, and `jq` to process the JSON, and finally redirect this into a file. The following command works well.  

`curl -s "https://api.instagram.com/oembed/?url=http://instagr.am/p/BjPSQKJFUYa" | jq -r ".html"`  

Now, before I continue I must admit at this point I found someone who implemented this exact thing and already wrapped it up into a shell script. So credit goes to [Wouter Bulten](https://www.wouterbulten.nl/blog/tech/import-instagram-for-jekyll/) for the informational post on this topic already. My simplified and custom solution meeting my specific needs is continued below.   

Now to just finalize the script, I add two dynamic variables. One for the path of the output file, hardcoded in the script. And the other is the required shortcode of the post of interest. The shortcode can be supplied as a command line argument or entered during execution when prompted.  

I saved the file under the name, `fetch_latest_instagram.sh`. Running the code therefore looks like `fetch_latest_instagram.sh BjPSQKJFUYa`, and then for me the embed code is written to the correct file in my `_includes` folder which I pick up on my [about page](https://knanne.github.io/about/).  

Note that I added an additional prompt before closing because on Windows the shell script opens in a new window, which automatically closes after execution, making it impossible to read if there was an error.

```shell
if [ $# -eq 0 ]
  then
    echo "Enter post shortcode:"
    read shortcode
else
  shortcode="$1"
fi

path="_includes\integrations\instagram_latest_photo.html"

echo "Fetching embed HTML of given post"
echo "Writing to $path"

curl -s "https://api.instagram.com/oembed/?url=http://instagr.am/p/$shortcode" | jq -r ".html" > "$path"

echo "Successfully wrote embed code to instagram_latest_photo.html"

echo "Type any key to close:"
read dummmy

echo "Closing"
```
