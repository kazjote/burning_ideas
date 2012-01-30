#About

This is a simple app which allows you to perform a brain storming with your remote friends in funny way.

It is my first app written in Clojure and Backbone.js so do not expect too much. It is only prototype. However, it works and you can use it as an example.

#Deploying

I use for deploy https://cloudbees.com

To create war file (you should have leiningen installed https://github.com/technomancy/leiningen):

```bash
cd backend
lein deps
lein ring uberwar
```

Your war file should be ready to deploy!

#Running localy

```bash
cd backend
lein deps
lein ring server
```

#Developing

Here we use sprockets https://github.com/sstephenson/sprockets to compile assets. You need to start 2 servers.

First one, rack, requires ruby (I tested it with 1.9.3) and following gems coffee-script, haml, sass, sprockets, rack.

You can install them using:

```bash
gem install coffee-script haml sass sprockets rack
```

You will also need some environment (like node.js) to execute standalone JavaScript code.

To start server
```bash
rackup
```

It will serve your assets and proxy all requests to the second backend server. To start backend server:

```bash
cd backend
lein deps
lein ring server
```


#License

The MIT License (MIT)

Copyright (c) 2011 Kacper Bielecki

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

