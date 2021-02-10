# TODO -> MODULARIZE POSSIBLY USING JSON-LIKE DATA HASHES

class Skeleton::CORSHandler
    include HTTP::Handler;

    private def check_for_options(context)
        if context.request.method == "OPTIONS"
            context.response.status = HTTP::Status::NO_CONTENT;
            # context.response.headers["Access-Control-Max-Age"] = "#{20.days.total_seconds.to_i}";
            context.response.headers["Content-Type"] = "text/plain";
            context.response.headers["Content-Length"] = "0";
            context;
        else
            call_next context;
        end
    end

    def call(context : HTTP::Server::Context)
        context.response.headers["Access-Control-Allow-Origin"] = "*";
        context.response.headers["Access-Control-Allow-Credentials"] = "true";
        context.response.headers["Access-Control-Allow-Methods"] = "*";
        context.response.headers["Access-Control-Allow-Headers"] = "DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,Authorization";
            
        check_for_options context;
    end
end
