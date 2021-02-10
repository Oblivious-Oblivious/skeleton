describe Skeleton::FileIOHandler do
    it "is an HTTP handler" do
        fileio_handler = Skeleton::FileIOHandler.new;
        fileio_handler.responds_to?(:call).should eq true;
    end
end
