# Chaff

Chaff is a blogging engine that reads a git repo full of markdown articles and presents them as a website.

Chaff is a derivative of [wheat][], the great blogging engine from [creationix][]

This derivitive has been created due to both a lack of activity on the [wheat][] repo, and a desire to include features that have not been included.

## How to Install

Manually install all the dependencies.

    cd chaff
    npm install
    cd <site>
    cp -r chaff node_modules

For on the fly rendering of Graphviz graphs (DOT files), Graphviz will need to be [installed](http://www.graphviz.org/Download..php)

That's it!  Checkout the chaff branch of abovethewater.co.uk for an example of how to use the library.

<http://github.com/abovethewater/abovethewater.co.uk>

## Configuration

[nconf][] is used for configuration of globals

Configuration is expected in conf/config.json

### markdownSuffix

default : 'markdown'

Allows the suffix to be changed.
This is global, so all markdwon files must be consistently named.

### templateEngine

default : 'haml'

Allows the template engine being used to be changed to one of the user's choice

Haml and jade are the only engines currently supported out the box.
Haml is the default, and is a dependency of chaff.

### templateSuffix

default : templateEngine

Allows the suffix of the templates to be defined.  Defaults tot he same value as the engine (most use cases).

### todo

Create a rendering engine adapter for various engines
- compile
- render

### templateSuffix

default : templateEngine

[wheat]: https://github.com/creationix/wheat
[nconf]: https://github.com/flatiron/nconf
[creationix]: http://github.com/creationix

