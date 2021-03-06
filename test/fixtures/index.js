// Generated by CoffeeScript 1.8.0
(function() {
  var async, fs, mongoose, _;

  mongoose = require('mongoose');

  async = require('async');

  fs = require('fs');

  _ = require('underscore');

  require('../models');

  exports.data = {};

  exports.refresh = function(done) {
    return async.series([exports.resetDb, exports.autoLoad], done);
  };

  exports.load = function(collection, data, callback) {
    return collection.create(data, callback);
  };

  exports.autoLoad = function(callback) {
    var directory, endsWithJs;
    directory = __dirname;
    endsWithJs = /\.js$/;
    return fs.readdir(directory, function(err, files) {
      return async.each(files, function(file, callback) {
        var data, dataArray, fileWithoutExt, fixtureConfig, model, modelName;
        if (!endsWithJs.test(file) || file === 'index.js') {
          return callback();
        }
        fixtureConfig = require(directory + '/' + file);
        fileWithoutExt = file.slice(0, -3);
        modelName;
        model;
        data;
        if (_.isArray(fixtureConfig)) {
          modelName = fileWithoutExt;
          model = mongoose.model(modelName);
          data = fixtureConfig;
        } else if (_.isObject(fixtureConfig)) {
          modelName = fixtureConfig.model;
          model = mongoose.model(modelName);
          if (fixtureConfig.discriminator) {
            model = model.discriminators[fixtureConfig.discriminator];
          }
          data = fixtureConfig.data;
        } else {
          throw 'Fixture ' + file + ' is neither array or object';
        }
        if (_.isArray(data)) {
          return model.create(data, function(err) {
            var argArray;
            argArray = _.toArray(arguments);
            exports.data[fileWithoutExt] = argArray.slice(1, argArray.length);
            return callback(err);
          });
        } else if (_.isObject(data)) {
          exports.data[fileWithoutExt] = {};
          dataArray = _.map(data, function(v, k) {
            var res;
            res = {
              k: k,
              v: v
            };
            return res;
          });
          return async.each(dataArray, function(data, callback) {
            return model.create(data.v, function(err, res) {
              exports.data[fileWithoutExt][data.k] = res;
              return callback();
            });
          }, callback);
        } else {
          throw 'Data for fixture ' + file + ' is neither array or object';
        }
      }, callback);
    });
  };

  exports.resetDb = function(done) {
    var collections;
    collections = Object.keys(mongoose.connection.collections);
    return async.each(collections, function(name, cb) {
      return mongoose.connection.collections[name.toString()].drop(function(err) {
        return cb();
      });
    }, done);
  };

}).call(this);
