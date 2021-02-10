class Skeleton::DatabaseHandler
    include HTTP::Handler;

    def call(context : HTTP::Server::Context)
        call_next context;
    end
end
