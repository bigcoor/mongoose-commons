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
timestamps = require("mongoose-commons").timestamp

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
    timestamps = require("mongoose-commons").timestamp;

var ExampleSchema = new Schema({});
ExampleSchema.plugin(timestamps);

var example = mongoose.model("Example", ExampleSchema);
```

Again, if you'd like to change the name of the key properties in your document just then when calling the plugin method with the `createdAt` and `updatedAt` options
```
ExampleSchema.plugin(timestamps, { createdAt: "created_at", updatedAt: "updated_at" });
```
The MIT License (MIT)

Copyright (c) 2014 meepo@bigcoor.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.