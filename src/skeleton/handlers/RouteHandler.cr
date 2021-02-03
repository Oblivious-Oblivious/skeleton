require "http/server"
require "radix"

module Skeleton
    class RouteHandler
        alias Callback = HTTP::Server::Context, Hash(String, String) -> HTTP::Server::Context;
        # alias RouteContext = NamedTuple(callback: Callback, params: Hash(String, String));

        include HTTP::Handler;

        getter :tree, :static_routes;

        def initialize
            @tree = Radix::Tree(Callback).new;
            @static_routes = {} of String => Callback;
        end

        def add_route(key : String, callback : Callback)
            if key.includes?(':') || key.includes?('*')
                tree.add key, callback;
            else
                static_routes[key] = callback;
                if key.ends_with? '/'
                    static_routes[key[0..-2]] = callback;
                else
                    static_routes[key + '/'] = callback;
                end
            end
        end

        def search_route(context : HTTP::Server::Context) : NamedTuple(callback: Callback, params: Hash(String, String))?
            search_path = '/' + context.request.method + context.request.path;

            callback = static_routes[search_path];
            return {
                callback: callback,
                params: {} of String => String
            } if callback;

            route = tree.find search_path;
            return {
                callback: route.payload,
                params: route.params
            } if route.found?;

            nil;
        end

        {% for req in %w(get post put delete options patch) %}
            def {{req.id}}(path : String, &block : Callback)
                add_route "/{{req.id.upcase}}" + path, block;
            end
        {% end %}

        def call(context : HTTP::Server::Context)
            if route_context = search_route context
                route_context[:callback].call context, route_context[:params];
            else
                call_next context;
            end
        end
    end
end
