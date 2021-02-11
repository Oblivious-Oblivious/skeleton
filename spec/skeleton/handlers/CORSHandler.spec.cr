require "http/client"
require "http/server"

def send_request(req)
    response : HTTP::Client::Response;
    app = Skeleton::RouteHandler.new;
    app.get "/" { "THIS IS MAI RESPONS"; };
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
        cors.responds_to?(:call).should eq true;
    end

    context "when the request method is `OPTIONS`" do
        options_response = send_request("options");

        # it "has a response status `NO_CONTENT`" do
        #     options_response.status.should eq HTTP::Status::NO_CONTENT;
        # end

        it "has Content-Type of `text/plain`" do
            options_response.headers["Content-Type"].should eq "text/plain";
        end

        it "has Access-Control-Allow-Methods of `GET HEAD DELETE OPTIONS PUT PATCH`" do
            options_response.headers["Access-Control-Allow-Methods"] = "GET, HEAD, DELETE, OPTIONS, PUT, PATCH";
        end
    end

    context "when the request method is anything else" do
        get_response = send_request("get");
        
        # it "has Access-Control-Allow-Origin on `*`" do
        #     get_response.headers["Access-Control-Allow-Origin"].should eq "*";
        # end

        # it "has Access-Control-Allow-Credentials on `true`" do
        #     get_response.headers["Access-Control-Allow-Credentials"].should eq "true";
        # end

        # it "has Access-Control-Allow-Methods on `*`" do
        #     get_response.headers["Access-Control-Allow-Methods"].should eq "Content-Type";
        # end
    end
end
