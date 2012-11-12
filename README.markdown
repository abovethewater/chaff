# Wheat

Wheat is a blogging engine that reads a git repo full of markdown articles and presents them as a website.

## How to Install

Either manually install all the dependencies or use npm.  It's packaged nicely now.

    npm install wheat

For on the fly rendering of Graphviz graphs (DOT files), Graphviz will need to be [installed](http://www.graphviz.org/Download..php)

That's it!  Checkout the wheat branch of howtonode.org for an example of how to use the library.

<http://github.com/creationix/howtonode.org>

## Configuration

[nconf][] is used for configuration of globals

### templateEngine

default : 'haml'

Allows the template engine being used to be changed to one of the user's choice

Haml and jade are the only engines currently supported out the box.
Haml is the default, and is a dependency of chaff.

### todo

Create a rendering engine adapter for various engines
- compile
- render

### templateSuffix

default : templateEngine

[nconf]: https://github.com/flatiron/nconf

