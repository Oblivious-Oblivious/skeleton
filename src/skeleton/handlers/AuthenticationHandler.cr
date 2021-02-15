class Skeleton::Authenticator
    getter :user, :pass;

    def initialize(
        @user : String?,
        @pass : String?
    )
    end

    def authorized?(username, password)
        user == username && pass == password;
    end
end

class Skeleton::AuthenticationHandler
    include HTTP::Handler;

    BASIC = "Basic";
    AUTH = "Authorization";
    LOGIN_REQ = "Basic realm=\"Login Required\"";

    property authenticator : Skeleton::Authenticator;

    private def authorized?(value)
        username, password = Base64.decode_string(value[BASIC.size + 1..-1]).split(':');
        authenticator.authorized? username, password;
    end

    private def fail_to_authenticate(context)
        # We did not authenticate
        headers = HTTP::Headers.new;
        context.response.status_code = 401;
        context.response.headers["WWW-Authenticate"] = LOGIN_REQ;
        context.response.print "Could not authenticate";
        "";
    end

    private def value_is_valid?(value)
        # Check for value nullity here
        value && value.size > 0 && value.starts_with? BASIC;
    end

    private def authorize_non_nil_value(context, value)
        if authorized? value
            call_next context;
        else
            fail_to_authenticate context;
        end
    end

    private def perform_authentication(context, value)
        if value_is_valid? value
            authorize_non_nil_value context, value;
        else
            fail_to_authenticate context;
        end
    end

    def initialize(
        user : String?,
        pass : String?
    )
        @authenticator = Skeleton::Authenticator.new user, pass;
    end

    def call(context : HTTP::Server::Context)
        perform_authentication context, context.request.headers[AUTH];
    end
end
