class Article

    constructor: () ->

        @meta =
            title : ""
            author: ""
            date: ""

        @origContent = {}

        @htmlContent = ""

        @publish = false

module.exports = Article