describe Skeleton::SessionHandler do
    it "is an HTTP handler" do
        session_handler = Skeleton::SessionHandler.new;
        session_handler.methods.should contain "call";
    end
end
