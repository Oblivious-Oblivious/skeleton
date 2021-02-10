describe Skeleton::CompressHandler do
    it "is an HTTP handler" do
        compress_handler = Skeleton::CompressHandler.new;
        compress_handler.responds_to?(:call).should eq true;
    end
end
