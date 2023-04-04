# mulle-testproto

#### 👯 mulle-testproto turns markdown into HTML

**mulle-testproto** uses the [hoedown](//github.com/hoedown/hoedown)
library wrapped into [MulleHoedown](//github.com/MulleWeb/MulleHoedown) to
convert [Markdown](//en.wikipedia.org/wiki/Markdown) into
[HTML](https://en.wikipedia.org/wiki/HTML).

You can get `mulle-testproto` to add a stylesheet to your HTML output. That
makes it convenient for quick previewing of markdown files. This command
sequence produces a nicely styled and readable HTML output file for consumption
in a browser:


```console
mulle-testproto -m < README.md > README.html
open README.html        # xdg-open README.html (linux)
```

> There is also a convenience script `mulle-testproto-preview`, which opens a
> README.md file in the brower.

## Usage

```console
   mulle-testproto [options]

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
echo "# hello" | mulle-testproto -c
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
> mulle-testproto does not pretty print the resulting HTML. You may want to
> chain it with mulle-tidy for nicer output.


## mulle-testproto as a musl or cosmopolitan static executable

`mulle-testproto` is a small showcase on how to compile mulle-objc with
[musl](//musl.libc.org) or [cosmopolitan](//justine.lol/cosmopolitan/index.html)
into a standalone static/cross-platform executable. The craft for musl or
cosmpolitan must be done on linux though.
The C libraries are considered SDKs and can be selected with:

``` sh
mulle-sde env --os-linux set MULLE_CRAFT_SDKS "cosmopolitan:musl:default"
```
> #### SDK selection via sourcetree
>
> See `mulle-sourcetree list --output-format cmd` on how to add cosmopolitan or
> musl added to a sourcetree. Pay attention to the `only-craft-sdk-<name>`
> marks.
>

### You are here

![Overview](overview.dot.svg)


## Build

This is a [mulle-sde](https://mulle-sde.github.io/) project.

It comes with its own virtual environment and list of dependencies.
To fetch and build everything say:

```
mulle-sde craft
```
