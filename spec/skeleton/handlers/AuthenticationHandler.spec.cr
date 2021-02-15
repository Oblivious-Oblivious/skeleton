def get_io_context(handler, request)
    io = IO::Memory.new;
    response = HTTP::Server::Response.new io;
    context = HTTP::Server::Context.new request, response;
    handler.call context;
    response.close;
    io.rewind;

    { io, context };
end

describe Skeleton::Authenticator do
    it "authorizes the credentials" do
        auth = Skeleton::Authenticator.new "oblivious", "42password";
        auth.authorized?("oblivious", "42password").should eq true;
        auth.authorized?("oblivious", "wrong").should eq false;
        auth.authorized?("non existent username", "whatever").should eq false;
        auth.authorized?("non existent username", "42password").should eq false;
        auth.authorized?("", "something").should eq false;
        auth.authorized?("something", "").should eq false;
        auth.authorized?("", "").should eq false;
    end
end

describe Skeleton::AuthenticationHandler do
    it "is an HTTP handler" do
        auth_handler = Skeleton::AuthenticationHandler.new("", "");
        auth_handler.responds_to?(:call).should eq true;
    end

    it "authorizes with correct credentials" do
        auth = Skeleton::AuthenticationHandler.new "oblivious", "42password";
        request = HTTP::Request.new "GET", "/",
            headers: HTTP::Headers {"Authorization" => "Basic b2JsaXZpb3VzOjQycGFzc3dvcmQ="};
        io, context = get_io_context auth, request;
        response = HTTP::Client::Response.from_io io, decompress: false;
        response.status_code.should eq 404;
    end

    it "returns a 401 error on wrong credentials" do
        auth = Skeleton::AuthenticationHandler.new "oblivious", "false pass";
        request = HTTP::Request.new "GET", "/",
            headers: HTTP::Headers {"Authorization" => "Basic b2JsaXZpb3VzOjQycGFzc3dvcmQ="};
        io, context = get_io_context auth, request;
        response = HTTP::Client::Response.from_io io, decompress: false;
        response.status_code.should eq 401;
    end

    it "returns a 401 error on without authentication" do
        auth = Skeleton::AuthenticationHandler.new "oblivious", "42password";
        request = HTTP::Request.new "GET", "/",
            headers: HTTP::Headers {"Authorization" => "random stuff"};
        io, context = get_io_context auth, request;
        response = HTTP::Client::Response.from_io io, decompress: false;
        response.status_code.should eq 401;
    end
end
