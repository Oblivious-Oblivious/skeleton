require "./Renderable"

class Skeleton::Application::JSON
    include Skeleton::Renderable;

    getter :data;

    # TODO -> Make data a generic value
    def initialize(
        @data : String
    )
    end

    def render_type
        "application/json";
    end

    def render(context : HTTP::Server::Context) : HTTP::Server::Context
        context.response.content_type = render_type;
        context.response.print data;
        context;
    end
end
