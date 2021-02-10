describe Skeleton::EmailHandler do
    it "is an HTTP handler" do
        email_handler = Skeleton::EmailHandler.new;
        email_handler.responds_to?(:call).should eq true;
    end
end
