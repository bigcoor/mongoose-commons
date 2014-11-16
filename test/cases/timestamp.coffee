mocha = require "mocha"
should = require "should"
TestCustomModel = require("../models/timestampCustom")
TestModel = require("../models/timestamp")

describe "mongoose-common", ->
  it "should create properties `createdAtAt` and `updatedAt`", (done) ->
    timestamp = Date.now()
    new TestModel().save((err, doc) ->
      if err then done err
      doc.createdAt.should.be.within timestamp, Date.now()
      doc.updatedAt.should.be.within timestamp, Date.now()
      done()
    )

  it "should only set updatedAt when a doc is being updated", (done) ->
    test = new TestModel()
    test.save (err, old) ->
      if err then done err
      oldCache = {
        createdAt: old.createdAt,
        updatedAt: old.updatedAt
      }
      setTimeout ->
        test.save (err, doc) ->
          if err then done err
          doc.updatedAt.should.be.above doc.createdAt
          doc.updatedAt.should.be.above oldCache.updatedAt
          doc.createdAt.should.be.equal oldCache.createdAt
          done()
      , 1000

  it "should create properties `posted` and `updated` instead of `createdAt` and `updatedAt`", (done) ->
    timestamp = Date.now()
    new TestCustomModel().save((err, doc) ->
      if err then done err
      doc.posted.should.be.within timestamp, Date.now()
      doc.updated.should.be.within timestamp, Date.now()
      done()
    )

