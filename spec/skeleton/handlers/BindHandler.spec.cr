describe Skeleton::BindHandler do
    it "is an HTTP handler" do
        bind_handler = Skeleton::BindHandler.new;
        bind_handler.methods.should contain "call";
    end
end
