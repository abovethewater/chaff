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
        it('should have an decode function', () ->
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
        it('should return with undefined if missing author', () ->
            content = fs.readFileSync( "test/articles/noauthor.md" );            
            output = adapter.decode(content)
            should.not.exist(output)
        )                        
        it('should return with undefined if missing title', () ->
            content = fs.readFileSync( "test/articles/notitle.md" );            
            output = adapter.decode(content)
            should.not.exist(output)
        )                        
        it('should return with undefined if missing text', () ->
            content = fs.readFileSync( "test/articles/notext.md" );            
            output = adapter.decode(content)
            should.not.exist(output)
        )                        
        it('should return a valid object if content passed in', () ->
            content = fs.readFileSync("test/articles/minimum.md" );            
            output = adapter.decode(content)
            should.exist(output)
        )                
        it('should return a valid metadata title when reading a file', () ->
            content = fs.readFileSync( "test/articles/minimum.md" );            
            output = adapter.decode(content)
            (output.meta.title).should.equal('Test')
        )        
        it('should return a valid metadata author when reading a file', () ->
            content = fs.readFileSync( "test/articles/minimum.md" );            
            output = adapter.decode(content)
            (output.meta.author).should.equal('Tester')
        )                
        it('should handle a missing newline gracefully', () ->
            content = fs.readFileSync( "test/articles/nonewline.md" );            
            output = adapter.decode(content)
            (output.meta.author).should.equal('Tester')
        )                        
        it('should return a valid metadata author when reading a different file', () ->
            content = fs.readFileSync( "test/articles/minimum2.md" );            
            output = adapter.decode(content)
            (output.meta.author).should.equal('Testar')
        )  
        it('should return the original Content when reading a file', () ->
            content = fs.readFileSync( "test/articles/minimum.md" );            
            output = adapter.decode(content)
            (output.origContent).should.equal('# text')
        )    
        it('should retain newlines from the original Content when reading a file', () ->
            content = fs.readFileSync( "test/articles/multiLine.md" );            
            output = adapter.decode(content)
            (output.origContent).should.equal('# text\n\n#line 3\n')
        )            
    )
)