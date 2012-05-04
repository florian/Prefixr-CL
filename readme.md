# Prefixr on the command line

[prefixr.com](http://prefixr.com) is an awesome tool that adds vendor prefixes to your CSS. 
While it certainly does a great job, 
always copying and pasting the CSS between editor and browser doesn't quite fit into my workflow. 
Prefixr-CLI provides an easy way to query the Prefixr API on the command line.

## Why not use one of the editor plugins?

I like to keep my CSS files as small as possible and only include the prefixed properties in the production (minified)
version. The editor extensions add the prefixed CSS to the current file which makes it a lot bigger and harder to maintain.
Prefixr-CLI saves the prefixed CSS in a seperate file.

## Requirements

1. An Unix-like operating system – Mac OS X or any Linux distribution will do.
- This script is written in Ruby, so you need to have Ruby installed.
- Root access. (Only for the installation.)
- CURL installed.

## Installation

1. Open your prefered terminal.
- Execute `$ curl -s https://raw.github.com/js-coder/prefixr-cl/master/install.sh | sh`

*Note that you need to run the installation script as root, that means that you might have to tweak the above code 
a little bit. For example on Debian (➞ Ubuntu):* `$ curl -s https://raw.github.com/js-coder/prefixr-cl/master/install.sh | sudo sh`

## Usage

This retrieves the CSS in *styles.css* and prints the prefixed CSS onto the terminal:
```bash
$ prefixr styles.css
```

This retrieves the CSS in *styles.css* and writes the prefixed CSS in the *styles_prefixed.css* file:
```bash
$ prefixr styles.css > styles_prefixed.css
```
You can also add several CSS files. The CSS in the files will be concatenated, prefixed and written into the *styles_prefixed.css* file. 
```bash
$ prefixr styles.css styles2.css > styles_prefixed.css
```
----

You can also output the usage of this script in the terminal:
```bash
$ prefixr --help
# Does the same as calling prefixr without any arguments:
$ prefixr
```

To print the version number in the terminal:
```bash
$ prefixr --version
# or
$ prefixr -v
```

## Ideas for further improvements

-  A watch mode: `--watch`. If enabled, everytime one of the CSS files is saved, Prefixr-CLI saves the prefixed CSS. Unfortunately this conflicts with the `>` bash operator, so I'll have to figure out an alternative syntax.
-  Throw an error and exit the script if one of the input file doesn't exist.

If you have any other ideas please let me know. You can either fork this repo and submit a pull request or open an [issue](https://github.com/js-coder/Prefixr-CLI/issues).