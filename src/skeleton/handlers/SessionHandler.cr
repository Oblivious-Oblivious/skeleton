class Skeleton::SessionHandler
    include HTTP::Handler;

    def call(context : HTTP::Server::Context)
        call_next context;
    end
end
