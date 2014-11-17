mocha = require "mocha"
should = require "should"
mongoose = require "mongoose"
Schema = mongoose.Schema

timestamp = require "../../"

TestSchema = new Schema {}
TestSchema.plugin timestamp
TestModel = mongoose.model("Test", TestSchema)

module.exports = TestModel


