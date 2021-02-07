describe Skeleton::RouteHandler do
    app = Skeleton::RouteHandler.new;
    app.get "/" { |context| context; };
    app.get "/path1/" { |context| context; };
    app.get "/path2/subpath" { |context| context; };
    app.get "/path3/:var1" { |context| context; };
    routes = app.static_routes;
    tree = app.tree;

    it "is an HTTP handler" do
        route_handler = Skeleton::RouteHandler.new;
        route_handler.methods.should contain "call";
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

    # it "saves variables in the tree" do
    # end
end
