path     = require('path')
fs       = require('fs')
mongoose = require('mongoose')
files    = fs.readdirSync(__dirname)

files.forEach((file) ->
  endsWithJs = /\.js$/
  if !endsWithJs.test(file) or file == 'index.js'
    return

  name = path.basename(file, '.js')
  return if name == 'index'

  mod = require('./' + name)
  if mod.model
    module.exports[name] = mod
  else
    module.exports[name] = mongoose.model(name, mod)
)