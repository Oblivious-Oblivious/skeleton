require "http/client"
require "http/server"

def send_request(req)
    response : HTTP::Client::Response;
    app = Skeleton::RouteHandler.new;
    app.get "/" { |c, p| c.response.print "THIS IS MAI RESPONS"; c; };
    server = Skeleton::Server.new
        .add(Skeleton::CORSHandler.new)
        .add(app)
        .bind_tcp("127.0.0.1", 8888);
    spawn { server.listen };
    client = HTTP::Client.new "127.0.0.1", 8888;
    case req
    when "get"
        response = client.get("/");
    when "options"
        response = client.options("/");
    else
        response = client.get("/");
    end
    server.close;
    response;
end

describe Skeleton::CORSHandler do
    it "is an HTTP handler" do
        cors = Skeleton::CORSHandler.new;
        cors.methods.should contain "call";
    end

    context "when the request method is `OPTIONS`" do
        options_response = send_request("options");
        it "has a response status of NO_CONTENT" do
            options_response.status.should eq HTTP::Status::NO_CONTENT;
        end

        it "has Content-Type of `text/plain`" do
            options_response.headers["Content-Type"].should eq "text/plain";
        end
        
        it "has Content-Length of `0`" do
            options_response.headers["Content-Length"].should eq "0";
        end
    end

    context "when the request method is anything else" do
        get_response = send_request("get");
        it "has Access-Control-Allow-Origin on `*`" do
            get_response.headers["Access-Control-Allow-Origin"].should eq "*";
        end

        it "has Access-Control-Allow-Credentials on `true`" do
            get_response.headers["Access-Control-Allow-Credentials"].should eq "true";
        end

        it "has Access-Control-Allow-Methods on `*`" do
            get_response.headers["Access-Control-Allow-Methods"].should eq "*";
        end

        it "has Access-Control-Allow-Headers on `DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,Authorization`" do
            get_response.headers["Access-Control-Allow-Headers"].should eq "DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,Authorization";
        end
    end
end
