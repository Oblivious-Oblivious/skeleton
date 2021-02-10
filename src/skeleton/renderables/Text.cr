require "./renderable"

class Skeleton::Text::HTML
    include Skeleton::Renderable;

    getter :page;

    def initialize(
        @page : String
    )
    end

    def render_type
        "text/html";
    end

    def render(context : HTTP::Server::Context) : HTTP::Server::Context
        context.response.content_type = render_type;
        context.response.content_length = File.size(page);
        puts Dir.current;
        File.open(page) do |file|
            IO.copy(file, context.response);
        end
        context;
    end
end

class String
    include Skeleton::Renderable;

    def render_type
        "text/plain";
    end

    def render(context : HTTP::Server::Context) : HTTP::Server::Context
        context.response.content_type = render_type;
        context.response.print self;
        context;
    end
end
