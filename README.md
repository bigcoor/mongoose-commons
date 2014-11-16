mongoose-commons
================

Mongoose common plugins executed on all Schemas.[Learn from mongoose-times](https://github.com/nicholasconfer/mongoose-times)

## Installation

```
npm install mongoose-commons
```

For more details, visit the [mongoose-commons on npm](https://npmjs.org/package/mongoose-commons) page

## Usage

The examples below create a model that will include `createdAt` and `updatedAt` properties in their schema.  Those properties will have timestamps that are automatically generated and updated when you save your document.

### CoffeeScript Example
```CoffeeScript
mongoose = require "mongoose"
timestamps = require "mongoose-commons"

ExampleSchema = new Schema {}
ExampleSchema.plugin timestamps

example = mongoose.model "Example", ExampleSchema
```
If you'd like to change the name of the key properties in your document just set them when calling the plugin method with the `createdAt` and `updatedAt` options
```
ExampleSchema.plugin timestamps, { createdAt: "created_at", updatedAt: "updated_at" }
```

### JavaScript Example
```JavaScript
var mongoose = require("mongoose"),
    timestamps = require("mongoose-commons");

var ExampleSchema = new Schema({});
ExampleSchema.plugin(timestamps);

var example = mongoose.model("Example", ExampleSchema);
```

Again, if you'd like to change the name of the key properties in your document just then when calling the plugin method with the `createdAt` and `updatedAt` options
```
ExampleSchema.plugin(timestamps, { createdAt: "created_at", updatedAt: "updated_at" });
```
