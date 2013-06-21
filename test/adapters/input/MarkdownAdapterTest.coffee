should = require('should')
adapter = require('../../../lib/adapters/MarkdownAdapter')
fs = require("fs")

class Callback
    constructor: (@done, @oncomplete) ->

    callback: (@data) =>
        @oncomplete(@data)
        @done()


describe('validate the markdown adapter', () ->
    describe('instantiation', () ->
        it('should not be null', () ->
            should.exist(adapter)
        )
        it('should have an encode function', () ->
            should.exist(adapter.decode)
        )                   
    )

    describe('decode', () ->
        it('should return with undefined if no content passed in', () ->
            output = adapter.decode()
            should.not.exist(output)
        )        
        it('should return with undefined if empty content passed in', () ->
            output = adapter.decode("")
            should.not.exist(output)
        )                
        it('should return a valid object if content passed in', () ->
            content = fs.readFileSync("test/articles/minimum.md" );            
            output = adapter.decode(content)
            should.exist(output)
        )                
        it('should return valid metadata when reading a file', () ->
            content = fs.readFileSync( "test/articles/minimum.md" );            
            output = adapter.decode(content)
            (output.meta.title).should.equal('Test')
        )        
    )
)