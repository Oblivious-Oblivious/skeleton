describe Skeleton::ErrorHandler do
    it "is an HTTP handler" do
        error_handler = Skeleton::ErrorHandler.new;
        error_handler.methods.should contain "call";
    end
end
