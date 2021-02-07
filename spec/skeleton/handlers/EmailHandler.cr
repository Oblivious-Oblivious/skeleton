describe Skeleton::EmailHandler do
    it "is an HTTP handler" do
        email_handler = Skeleton::EmailHandler.new;
        email_handler.methods.should contain "call";
    end
end
