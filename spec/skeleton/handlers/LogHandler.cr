describe Skeleton::LogHandler do
    it "is an HTTP handler" do
        log_handler = Skeleton::LogHandler.new;
        log_handler.responds_to?(:call).should eq true;
    end
end
