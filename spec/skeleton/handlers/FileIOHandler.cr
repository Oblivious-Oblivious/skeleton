describe Skeleton::FileIOHandler do
    it "is an HTTP handler" do
        fileio_handler = Skeleton::FileIOHandler.new;
        fileio_handler.methods.should contain "call";
    end
end
