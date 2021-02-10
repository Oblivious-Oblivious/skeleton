module Skeleton::Renderable
    def self.render_type
        "text/plain";
    end

    def self.render(context : HTTP::Server::Context) : HTTP::Server::Context
        context;
    end
end
