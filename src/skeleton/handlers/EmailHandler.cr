module Skeleton
    class EmailHandler
        include HTTP::Handler;

        def call(context : HTTP::Server::Context)
            call_next context;
        end
    end
end
