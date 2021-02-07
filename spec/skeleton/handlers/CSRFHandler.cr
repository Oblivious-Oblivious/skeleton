describe Skeleton::CSRFHandler do
    it "is an HTTP handler" do
        csrf_handler = Skeleton::CSRFHandler.new;
        csrf_handler.methods.should contain "call";
    end
end
