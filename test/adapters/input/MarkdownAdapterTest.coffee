should = require('should')
adapter = require('../../../lib/adapters/MarkdownAdapter')

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
        it('should callback with undefined if an invalid file passed in', (done) ->
            adapter.decode("test/notfound", new Callback(done, (output) ->
                should.not.exist(output)
            ).callback)
        )        
        it('should fail silently if no callback is passed in', () ->
            output = adapter.decode("test/notfound")
            should.not.exist(output)
        )                
        it('should return a valid object if a valid file passed in', (done) ->
            adapter.decode("test/articles/minimum.md", new Callback(done, (output) ->
                should.exist(output)
            ).callback)
        )                
    )
)