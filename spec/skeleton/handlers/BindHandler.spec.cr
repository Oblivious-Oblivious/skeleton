describe Skeleton::BindHandler do
    it "is an HTTP handler" do
        bind_handler = Skeleton::BindHandler.new;
        bind_handler.responds_to?(:call).should eq true;
    end
end
