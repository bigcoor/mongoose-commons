mongoose = require('mongoose')
async    = require('async')
fs       = require('fs')
_        = require('underscore')

require('../models')

exports.data = {}

exports.refresh = (done) ->
  async.series([
    exports.resetDb
    exports.autoLoad
  ], done)

exports.load = (collection, data, callback) ->
  collection.create(data, callback)

exports.autoLoad = (callback) ->
  directory  = __dirname
  endsWithJs = /\.js$/

  fs.readdir(directory, (err, files) ->
    async.each(files, (file, callback) ->
      if !endsWithJs.test(file) or file == 'index.js'
        return callback()

      fixtureConfig  = require(directory + '/' + file)
      fileWithoutExt = file.slice(0, -3)
      modelName
      model
      data

      if _.isArray(fixtureConfig)
        modelName = fileWithoutExt
        model = mongoose.model(modelName)
        data = fixtureConfig
      else if _.isObject(fixtureConfig)
        modelName = fixtureConfig.model
        model = mongoose.model(modelName)

        if fixtureConfig.discriminator
          model = model.discriminators[fixtureConfig.discriminator]

        data = fixtureConfig.data
      else
        throw 'Fixture ' + file + ' is neither array or object'

      if _.isArray(data)
        model.create(data, (err) ->
          argArray = _.toArray(arguments)
          exports.data[fileWithoutExt] = argArray.slice(1, argArray.length)
          callback(err)
        )
      else if _.isObject(data)
        exports.data[fileWithoutExt] = {}

        dataArray = _.map(data, (v, k) ->
          res =
            k : k
            v : v
          return res
        )

        async.each(dataArray, (data, callback) ->
          model.create(data.v, (err, res) ->
            exports.data[fileWithoutExt][data.k] = res
            callback()
          )
        , callback)
      else
        throw 'Data for fixture ' + file + ' is neither array or object'
    , callback)
  )

exports.resetDb = (done) ->
  collections = Object.keys(mongoose.connection.collections)
  async.each(collections, (name, cb) ->
    mongoose
    .connection
    .collections[name.toString()]
    .drop((err) ->
      cb()
    )
  , done)