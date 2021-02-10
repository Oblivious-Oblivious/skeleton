describe Skeleton::SessionHandler do
    it "is an HTTP handler" do
        session_handler = Skeleton::SessionHandler.new;
        session_handler.responds_to?(:call).should eq true;
    end
end
