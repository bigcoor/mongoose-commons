mocha = require "mocha"
should = require "should"
mongoose = require "mongoose"
Schema = mongoose.Schema

timestamp = require "../../"

TestCustomSchema = new Schema {}
TestCustomSchema.plugin timestamp, { createdAt: "posted", updatedAt: "updated" }
TestCustomModel = mongoose.model("TestCustom", TestCustomSchema)

module.exports = module.exports = TestCustomModel

