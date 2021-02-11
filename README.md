# Skeleton

[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?)](https://crystal-lang.org/)
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

# Initialize a server choose what middleware to add
server = Skeleton::Server.new
  .add(Skeleton::CORSHandler.new)
  .add(Skeleton::RouteHandler.new # Create a route handler for defining sinatra-like routes
    .get "/" {                    # Define all basic HTTP method routes with callback blocks
      "Hello World"               # Return a `Renderable` value
    }
  )
  .bind_tcp("127.0.0.1", 8080)    # Bind to an address on a port
  .listen;                        # Blocking listen

### Non blocking version
# spawn { server.listen }
###

```

## Development

Future additions / #TODOs

* Write proper documentation
* Refactor the `RouteHandler` to avoid conditionals and multiple execution paths
* Try to follow MVC more tightly

## Contributing

1. Fork it (<https://github.com/Oblivious-Oblivious/skeleton/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Oblivious](https://github.com/Oblivious-Oblivious) - creator and maintainer
