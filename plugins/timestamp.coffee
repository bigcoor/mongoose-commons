# default plugin options values
defaults = {
  createdAt: "createdAt",
  updatedAt: "updatedAt"
}

# dateJSON method to create JSON date property with key name
dateJSON = (key) ->
  json = {}
  json[key] = Date
  json

# mongoose timestamp plugin method
module.exports = exports.timestamp = (schema, options)->
  createdAt = if options and options.createdAt then options.createdAt else defaults.createdAt
  updatedAt = if options and options.updatedAt then options.updatedAt else defaults.updatedAt

  schema.add dateJSON(createdAt)
  schema.add dateJSON(updatedAt)

  schema.pre "save", (next) ->
    timestamp = Date.now()
    @[createdAt] = timestamp unless @[createdAt]?
    @[updatedAt] = timestamp
    next()