describe Skeleton::RouteHandler do
    app = Skeleton::RouteHandler.new
        .get "/" { "" }
        .get "/path1/" { "" }
        .get "/path2/subpath" { "" }
        .get "/path3/:var1" { "" };
    routes = app.static_routes;
    tree = app.tree;

    it "is an HTTP handler" do
        route_handler = Skeleton::RouteHandler.new;
        route_handler.responds_to?(:call).should eq true;
    end

    it "defines static paths without variables" do
        routes.keys.should contain "/GET";
        routes.keys.should contain "/GET/";
        routes.keys.should contain "/GET/path1";
        routes.keys.should contain "/GET/path1/";
        routes.keys.should contain "/GET/path2/subpath";
        routes.keys.should contain "/GET/path2/subpath/";
    end

    it "does not define variables" do
        routes.keys.should_not contain "/GET/path3/:var1/";
        routes.keys.should_not contain "/GET/path3/:var1";
    end

    it "returns the renderable value when then callback is called" do
    end

    # it "saves variables in the tree" do
    # end
end
