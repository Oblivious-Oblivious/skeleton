require "http/server"
require "radix"

module Skeleton
    # TODO -> REMOVE IF STATEMENTS
    class RouteHandler
        include HTTP::Handler;
        alias Callback = HTTP::Server::Context, Hash(String, String) -> HTTP::Server::Context;

        getter :tree, :static_routes;

        private def produce_call(context : HTTP::Server::Context)
            if route_request = search_route context.request
                route_request[:callback].call context, route_request[:params];
            else
                call_next context;
            end
        end

        private def produce_route_result(search_path)
            if callback = static_routes[search_path];
                {
                    callback: callback,
                    params: {} of String => String
                };
            elsif route = tree.find search_path
                {
                    callback: route.payload,
                    params: route.params
                };
            else
                nil;
            end
        end

        private def ensure_full_path(key : String, callback : Callback)
            if key.ends_with? '/'
                static_routes[key[0..-2]] = callback;
            else
                static_routes[key + '/'] = callback;
            end
        end

        private def setup_static_route_callback(key : String, callback : Callback)
            static_routes[key] = callback;
            ensure_full_path key, callback;
        end

        private def produce_route_addition(key : String, callback : Callback)
            if key.includes?(':') || key.includes?('*')
                tree.add key, callback;
            else
                setup_static_route_callback key, callback;
            end
        end

        private def add_route(key : String, callback : Callback)
            produce_route_addition key, callback;
        end

        private def search_route(request) : NamedTuple(callback: Callback, params: Hash(String, String))?
            produce_route_result '/' + request.method + request.path;
        end

        def initialize
            @tree = Radix::Tree(Callback).new;
            @static_routes = {} of String => Callback;
        end

        {% for req in %w(get post put delete head trace connect options patch) %}
            def {{req.id}}(path : String, &callback : Callback)
                add_route "/{{req.id.upcase}}" + path, callback;
            end
        {% end %}

        def call(context : HTTP::Server::Context)
            produce_call context;
        end
    end
end
