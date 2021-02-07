describe Skeleton::AuthenticationHandler do
    it "is an HTTP handler" do
        auth_handler = Skeleton::AuthenticationHandler.new;
        auth_handler.methods.should contain "call";
    end
end
