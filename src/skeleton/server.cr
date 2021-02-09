module Skeleton
    class Server
        getter :server, :address, :handlers;
        
        def initialize
            @server = HTTP::Server.new Skeleton::NullHandler.new;
            @address = Socket::IPAddress.new "0.0.0.0", 0;
            @handlers = [] of HTTP::Handler;
        end

        def create
            @server = HTTP::Server.new handlers;
            self;
        end

        def add(handler : HTTP::Handler)
            handlers << handler;
            self;
        end

        def addresses : Array(Socket::Address)
            server.addresses;
        end

        def bind(socket : Socket::Server) : self
            @address = server.bind socket;
            self;
        end

        def bind(uri : URI) : self
            @address = server.bind uri;
            self;
        end

        def bind(uri : String) : self
            @address = server.bind uri;
            self;
        end

        def bind_tcp(host : String, port : Int32, reuse_port : Bool = false)
            @address = server.bind_tcp host, port, reuse_port;
            self;
        end

        def bind_tcp(port : Int32, reuse_port : Bool = false) : self
            @address = server.bind_tcp(port, reuse_port);
            self;
        end

        def bind_tcp(ip_address : Socket::IPAddress, reuse_port : Bool = false) : self
            @address = server.bind_tcp ip_address, port;
            self;
        end

        def bind_tls(host : String, port : Int32, context : OpenSSL::SSL::Context::Server, reuse_port : Bool = false) : self
            @address = server.bind_tls host, port, context, reuse_port;
            self;
        end

        def bind_tls(address : Socket::IPAddress, context : OpenSSL::SSL::Context::Server) : self
            @address = server.bind_tls address, context;
            self;
        end

        def bind_tls(host : String, context : OpenSSL::SSL::Context::Server)
            @address = server.bind_tls host, context;
            self;
        end

        def bind_unix(path : String) : self
            @address = server.bind_unix path;
            self;
        end

        def bind_unix(uaddress : Socket::UNIXAddress) : self
            @address = server.bind_unix uaddress;
            self;
        end

        def bind_unused_port(host : String = Socket::IPAddress::LOOPBACK, reuse_port : Bool = false) : self
            @address = server.bind_unused_port host, reuse_port;
        end

        def each_address(&block : Socket::Address ->)
            server.each_address block;
        end

        def listen(port : Int32, reuse_port : Bool = false)
            puts "Listening on port #{port}";
            server.listen port, reuse_port;
        end

        def listen(host : String, port : Int32, reuse_port : Bool = false)
            puts "Listening on #{host}:#{port}";
            server.listen host, port, reuse_port;
        end

        def listen
            puts "Listening on http://#{address}";
            server.listen;
        end

        def listening?
            server.listening?;
        end

        def close
            puts "Closing gracefully";
            server.close;
        end

        def closed?
            server.closed?;
        end

        def max_headers_size
            server.max_headers_size;
        end
        def max_headers_size=(size : Int32)
            server.max_headers_size= size;
        end

        def max_request_line_size
            server.max_request_line_size;
        end
        def max_request_line_size=(size : Int32)
            server.max_request_line_size= size;
        end
    end
end
