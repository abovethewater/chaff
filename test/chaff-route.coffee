require('../lib/chaff')

# 
# modules for
# reading file metadata (default git)
# listing files for a given route (default git)
# reading file data (default markdown)
# rendering template
# adding extra metadata to HTML output (default copyright footer)
# 
#

describe('chaff route handling', () ->
    describe('normal routes', () ->
        it('should not fail', () ->
            (1).should.equal(1)
        )
    )
)