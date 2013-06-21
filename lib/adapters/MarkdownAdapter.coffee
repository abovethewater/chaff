Article = require('../Article')
fs = require('fs')

decode = (filename, callback) ->

    return if not filename or not callback

    fs.exists(filename, (exists) ->
        if (exists)
            article = new Article()
        callback(article)
    )

module.exports =
    decode : decode