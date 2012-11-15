var Step = require('step'),
    Markdown = require('./markdown'),
    Crypto = require('crypto'),
    Buffer = require('buffer').Buffer,
    Git = require('git-fs'),
    nconf = require('nconf'),
    datetime = require('datetime');

// stable for the lifetime of the app, so compiled once only
var fileSuffixRegex = undefined;

var Helpers = {
  inspect: require(process.binding('natives').util ? 'util' : 'sys').inspect,
  intro: function intro(markdown) {
    var html = Markdown.encode(markdown);
    return html.substr(0, html.indexOf("<h2"));
  },
  markdownEncode: function markdownEncode(markdown) {
    return Markdown.encode(markdown+"");
  },
  github: function github(name) {
    return '<a href="http://github.com/' + name + '">' + name + '</a>';
  },
  bitbucket: function bitbucket(name) {
    return '<a href="http://bitbucket.org/' + name + '">' + name + '</a>';
  },
  twitter: function twitter(name) {
    return '<a href="http://twitter.com/' + name + '">' + name + '</a>';
  },
  gravitar: function gravitar(email, size) {
    size = size || 200;
    var hash = Crypto.createHash('md5')
    hash.update((email+"").trim().toLowerCase())
    return "http://www.gravatar.com/avatar/" +
      hash.digest('hex') +
      "?r=pg&s=" + size + ".jpg&d=identicon";
  },
  formatDate: function formatDate(val, format, tz, locale) {
    return datetime.format(new Date(val), format, tz, locale);
  },
  formatRFC822Date: function formatRFC822Date(val) {
    return datetime.format(new Date(val), "%a, %d %b %Y %H:%M:%S %z");
  }

};

// Convert UTF8 strings to binary buffers for faster loading
function stringToBuffer(string) {
  var buffer = new Buffer(Buffer.byteLength(string));
  buffer.write(string, 'utf8');
  return buffer;
};

// Loads a template and caches in memory.
var loadTemplate = Git.safe(function loadTemplate(version, name, callback) {

  var templateEngine = nconf.get('templateEngine');

  Step(
    function loadHaml() {
      var suffix = nconf.get('templateSuffix');
      suffix = suffix || templateEngine;
      Git.readFile(version, "skin/" + name + "." + suffix, this);
    },
    function compileTemplate(err, template) {
      if (err) { callback(err); return; }
      var TemplateEngine = require(templateEngine);

      switch (templateEngine) {
        case 'haml':
              return TemplateEngine(template + "", (/\.xml$/).test(name));  
        case 'jade':
              return function(data) { return TemplateEngine.render(template, {locals:data}); };
        default: 
            callback("Couldn't load template for unknown engine " + templateEngine);
            return;        
      }
    },
    callback
  );
});

// Like loadTemplate, but doesn't require the version
function compileTemplate(name, callback) {
  Step(
    function getHead() {
      Git.getHead(this);
    },
    function loadTemplates(err, version) {
      if (err) { callback(err); return; }
      loadTemplate(version, name, this);
    },
    function (err, template) {
      if (err) { callback(err); return; }
      return function (data) {
        data.__proto__ = Helpers;
        return template.apply(this, arguments);
      };
    },
    callback
  );
};

function render(name, data, callback, partial) {
  Step(
    function getHead() {
      Git.getHead(this);
    },
    function loadTemplates(err, version) {
      if (err) { callback(err); return; }
      loadTemplate(version, name, this.parallel());
      if (!partial) {
        loadTemplate(version, "layout", this.parallel());
      }
    },
    function renderTemplates(err, template, layout) {
      if (err) { callback(err); return; }
      data.__proto__ = Helpers;
      var content = template(data);
      if (partial) { return stringToBuffer(content); }
      data = {
        content: content,
        title: data.title || ""
      };
      data.__proto__ = Helpers;
      return stringToBuffer(layout(data));
    },
    callback
  )
};

function markdown(filename) {

    if (!fileSuffixRegex) {
      fileSuffixRegex = new RegExp("\." + nconf.get("markdownSuffix") + "$");      
    }

    if (!fileSuffixRegex.test(filename)) {
      return;
    }
    var name = filename.replace(/\.[0-9a-z]{2,8}$/, '');
    return {
      name : name,
      filename : filename
    }
};

module.exports = {
  stringToBuffer: stringToBuffer,
  compileTemplate: compileTemplate,
  render: render,
  markdown : markdown
};
