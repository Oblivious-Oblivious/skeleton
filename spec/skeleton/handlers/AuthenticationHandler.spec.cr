describe Skeleton::AuthenticationHandler do
    it "is an HTTP handler" do
        auth_handler = Skeleton::AuthenticationHandler.new;
        auth_handler.responds_to?(:call).should eq true;
    end
end
