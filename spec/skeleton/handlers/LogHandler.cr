describe Skeleton::LogHandler do
    it "is an HTTP handler" do
        log_handler = Skeleton::LogHandler.new;
        log_handler.methods.should contain "call";
    end
end
