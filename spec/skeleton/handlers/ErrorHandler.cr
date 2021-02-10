describe Skeleton::ErrorHandler do
    it "is an HTTP handler" do
        error_handler = Skeleton::ErrorHandler.new;
        error_handler.responds_to?(:call).should eq true;
    end
end
