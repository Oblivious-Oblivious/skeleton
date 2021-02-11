# TODO -> MODULARIZE POSSIBLY USING JSON-LIKE DATA HASHES

class Skeleton::CORSHandler
    include HTTP::Handler;

    property :allow_origin, :allow_headers, :allow_methods, :allow_creds, :max_age;

    def initialize
        @allow_origin = "*";
        @allow_headers = "Accept, Content-Type";
        @allow_methods = "GET, HEAD, DELETE, OPTIONS, PUT, PATCH";
        @allow_creds = true;
        @max_age = 0;

        @response = "";
    end

    private def generate_allowed_method_response(context, requested_method)
        if allow_methods.includes? requested_method.strip
            context.response.headers["Access-Control-Allow-Methods"] = allow_methods;
        else
            context.response.status_code = 403;
        end
    end

    private def check_allowed_methods(context)
        if requested_method = context.request.headers["Access-Control-Request-Method"]
            generate_allowed_method_response context, requested_method;
        end
    end

    private def check_for_options(context)
        if context.request.method == "OPTIONS"
            context.response.status = HTTP::Status::NO_CONTENT;
            check_allowed_methods context;
            context.response.headers["Content-Type"] = "text/plain";
            context.response.headers["Content-Length"] = "0";
            context;
        else
            call_next context;
        end
    end

    def call(context)
        context.response.headers["Access-Control-Allow-Origin"] = allow_origin;
        context.response.headers["Access-Control-Allow-Credentials"] = "true" if allow_creds;
        context.response.headers["Access-Control-Max-Age"] = max_age.to_s if max_age > 0;
        context.response.headers["Access-Control-Allow-Headers"] = "Content-Type";

        check_for_options context;
    end
end
