describe Skeleton::NullHandler do
    it "is an HTTP handler" do
        fileio_handler = Skeleton::NullHandler.new;
        fileio_handler.methods.should contain "call";
    end
end
