Article = require('../Article')
fs = require('fs')
markdown = require('./vendor/markdown')

preProcessMarkdown = (content) ->

    content = content.toString() if typeof(content) isnt "string"

    props =
        meta : {}
        content: ""

    while (match = content.match(/^([a-z]+):\s*(.*)\s*\n/i)) 
        name = match[1].toLowerCase()
        value = match[2]
        content = content.substr(match[0].length)
        props.meta[name] = value

    props.origContent = content

    return props

decode = (content) ->

    return if not content or content.length is 0

    props = preProcessMarkdown(content)
    
    article = new Article(props.meta)
    return article

module.exports =
    decode : decode