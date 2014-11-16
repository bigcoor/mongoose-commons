mongoose = require('mongoose')
fs       = require('fs')
config   = require('./config')
fixtures = require('./fixtures')
chai     = require('chai')

chai.config.includeStack = true

mongoose.connect(config.MONGO)

describe null, ->
  # rest db and load fixtures before every test
  beforeEach(fixtures.refresh)

  endsWithJs = /\.js$/
  testDir   = __dirname + '/cases'

  fs.readdirSync(testDir).forEach((file) ->
    if endsWithJs.test(file)
      require('./cases/' + file)
  )
