// Generated by CoffeeScript 1.8.0
(function() {
  var files, fs, mongoose, path;

  path = require('path');

  fs = require('fs');

  mongoose = require('mongoose');

  files = fs.readdirSync(__dirname);

  files.forEach(function(file) {
    var endsWithJs, mod, name;
    endsWithJs = /\.js$/;
    if (!endsWithJs.test(file) || file === 'index.js') {
      return;
    }
    name = path.basename(file, '.js');
    if (name === 'index') {
      return;
    }
    mod = require('./' + name);
    if (mod.model) {
      return module.exports[name] = mod;
    } else {
      return module.exports[name] = mongoose.model(name, mod);
    }
  });

}).call(this);
