require "http/server"

module Skeleton
    # TODO -> REMOVE UNECESSARY CLASS VARIABLES
    class Server
        @server : HTTP::Server;
        @address : Socket::IPAddress;
        
        getter :server, :address;

        def initialize(handlers)
            @server = HTTP::Server.new handlers;
            @address = Socket::IPAddress.new "0.0.0.0", 0;
        end

        def bind(ip_address, port)
            @address = server.bind_tcp ip_address, port;
        end

        def listen
            puts "Listening on http://#{address}";
            server.listen;
        end
    end
end
