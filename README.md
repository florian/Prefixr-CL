# Prefixr on the command line

[prefixr.com](http://prefixr.com) is an awesome tool that adds vendor prefixes to your CSS.
Prefixr-CL is a node package that provides an easy way to query the Prefixr API in node and on the command line.

## Installation

Easy installation with [NPM](https://npmjs.org):

```sh
$ npm install -g prefixr
```

## Command line usage

```sh
$ prefixr

    Usage: prefixr --input <files> [output options] [other options]

    Examples:

      --input base.css app.css --output styles.css
       -i base app -o styles # Drop .css, use shortcut options.
       -i base -o styles -e ms o # Don't add prefixes for IE and Opera

    Meta:

      -h, --help              print usage information
      -v, --version           print the version number

    Input and output options:

      -i, --input <files>     the CSS files you want to prefix
      -o, --output <files>    write the prefixed CSS into <files>
      -s, --output-self       write the prefixed CSS into the input files
      -p, --print             print the prefixed CSS

    Other options:

      -c, --compress          compress the prefixed CSS
      -nv, --no-variables     keep variables
      -e, --exclude <vendors> exclude 'moz', 'ms' and / or 'o'
      -w, --watch             rerun command if an input file changes

```

This package queries *prefixr.com* itself, so the prefixing itself can take around one second, since a HTTP request is needed.

Prefix the contents of files and write the output to another file:
```sh
$ prefixr --input one.css two.css --output styles.css
$ prefixr -i one two -o styles # You can drop the '.css' extension.
```

Prefix the contents of files and write the prefixed CSS of each into those files:
```sh
$ prefixr --input one two --output-self
$ prefixr -i one two -s
```

Prefix the content of files and echo it into the terminal:
```sh
$ prefixr --input one.css --print
$ prefixr -i one -p
```

Exclude `-ms` and `-o`:
```sh
$ prefixr --input one.css -output-self -exclude ms o
$ prefixr -i one -s -e ms o
```

Compress the output:
```sh
$ prefixr --input one.css --output styles.css --compress
$ prefixr -i one -o styles -c
```

Watch mode:
```sh
$ prefixr --watch --input one.css two.css --output styles.css
$ prefixr -w -i one two -o styles
```

Meta stuff:
```sh
$ prefixr
$ prefixr -?
$ prefixr -h
$ prefixr --help

$ prefixr -v
$ prefixr --version
```

## Node usage

The node API provides two minimalistic functions to query the Prefixr API.

```javascript
var prefix = require('prefixr');

var css = 'div { box-shadow: 1px 0 2px black; }';
var options = {
	compress: true, // Default: false
	variables: true, // Default: true
	exclude: ['o', 'ms'] // Array with 'o', 'ms', 'moz' or just a plain string or 'all' to exclude all three options. Default: [].
};
var callback = function (prefixed) { console.log(prefixed); }

prefix(css, options, callback);
prefix(css, callback); // The options object can be dropped.

prefix.files('examples/styles.css', options, callback); // Prefix the contents of a file.
prefix.files('examples/styles', options, callback); // The '.css' extension can be dropped.
prefix.files(['examples/styles', 'examples/more_styles.css'], options, callback); // Prefix the contents of several files.
```

- - -

## Todo

- Refactoring – A lot.
- Fix watch mode in combination with `--output-self`.
- Print time + file name when an input file changes in watch mode.