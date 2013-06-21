Article = require('../Article')
fs = require('fs')
markdown = require('./vendor/markdown')

preProcessMarkdown = (content) ->

    content = content.toString() if typeof(content) isnt "string"

    props =
        meta : {}

    while (match = content.match(/^([a-z]+):\s*(.*)\s*\n/i)) 
        name = match[1].toLowerCase()
        value = match[2]
        content = content.substr(match[0].length)
        props.meta[name] = value

    props.origContent = content

    return props if props.meta.title && props.meta.author && props.origContent

decode = (content) ->

    return if not content or content.length is 0

    props = preProcessMarkdown(content)

    return if props is undefined
    
    article = new Article(props)
    return article

module.exports =
    decode : decode