# Skeleton

[![Version](https://img.shields.io/badge/version-0.2.1-orange)](https://github.com/Oblivious-Oblivious/Skeleton/releases/latest)
[![GPLv3 License](https://img.shields.io/badge/license-GPL%20v3-yellow.svg)](./COPYING) 

[![Build Status](https://travis-ci.com/Oblivious-Oblivious/skeleton.svg?branch=master)](https://travis-ci.com/github/Oblivious-Oblivious/Skeleton)

A very minimal http server api serving as a platform for incremental middleware.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     skeleton:
       github: Oblivious-Oblivious/skeleton
   ```

2. Run `shards install`

## Usage

```crystal
require "skeleton"

# Create a route handler for defining sinatra-like routes
app = Skeleton::RouteHandler.new

# Define all basic HTTP method routes with callback blocks
app.get "/" do |context|
  # Use a regular HTTP::Context object
  context.response.print "Hello, World"

  # Each route returns the updated context back
  context;
end

# Initialize a server choose what middleware to add
server = Skeleton::Server.new
  .add(Skeleton::CORSHandler.new)
  .add(app)
  .bind_tcp("127.0.0.1", 8080) # Bind to an address on a port
  .listen;                     # Blocking listen

### Non blocking version
# spawn { server.listen }
###

```

## Development

Future additions / #TODOs

* Write proper documentation
* Make `CORSHandler` accept custom parameters.
* Modularize the `CORSHandler` using json-like data hashes
* Refactor the `RouteHandler` to avoid conditionals and multiple execution paths
* Make the `RouteHandler` serve static html
* Try to follow MVC more tightly

## Contributing

1. Fork it (<https://github.com/Oblivious-Oblivious/skeleton/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Oblivious](https://github.com/Oblivious-Oblivious) - creator and maintainer
