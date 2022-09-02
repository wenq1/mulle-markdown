# mulle-markdown

#### 👯 mulle-markdown turns markdown into HTML

**mulle-markdown** uses the [hoedown](//github.com/hoedown/hoedown)
library wrapped into [MulleHoedown](//github.com/MulleWeb/MulleHoedown) to
convert [Markdown](//en.wikipedia.org/wiki/Markdown) into
[HTML](https://en.wikipedia.org/wiki/HTML).

You can get `mulle-markdown` to add a stylesheet to your HTML output. That
makes it convenient for quick previewing of markdown files. This command
sequence produces a nicely styled and readable HTML output file for consumption
in a browser:


```console
mulle-markdown -m < README.md > README.html
open README.html        # xdg-open README.html (linux)
```

`mulle-markdown` is a small showcase on how to compile mulle-objc with musl into a
standalone static executable.


## Usage

```console
   mulle-markdown [options]

   Reads markdown from stdin, writes HTML to stdout.

Options:
   -c         : emit link to "style.css" (implies -w)
   -i         : inline "style.css" into HTML head (implies -w)
   -m         : inline a hardcoded style.css (implies -w)
   -t <title> : set title of HTML document (implies -w)
   -w         : wrap with HTML header and footer
```

## Example

```console
echo "# hello" | mulle-markdown -c
```

emits

```html
<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>
<h1>hello</h1>
</body>
</html>
```

> ### Note
>
> mulle-markdown does not pretty print the resulting HTML. You may want to
> chain it with mulle-tidy for nicer output.


### You are here

![Overview](overview.dot.svg)


## Build

This is a [mulle-sde](https://mulle-sde.github.io/) project.

It comes with its own virtual environment and list of dependencies.
To fetch and build everything say:

```
mulle-sde craft
```
