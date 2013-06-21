class Article

    constructor: (meta) ->

        @meta = meta ||
            title : ""
            author: ""
            date: ""

module.exports = Article