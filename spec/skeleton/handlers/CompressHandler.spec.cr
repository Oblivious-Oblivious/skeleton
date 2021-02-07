describe Skeleton::CompressHandler do
    it "is an HTTP handler" do
        compress_handler = Skeleton::CompressHandler.new;
        compress_handler.methods.should contain "call";
    end
end
