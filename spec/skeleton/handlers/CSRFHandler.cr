describe Skeleton::CSRFHandler do
    it "is an HTTP handler" do
        csrf_handler = Skeleton::CSRFHandler.new;
        csrf_handler.responds_to?(:call).should eq true;
    end
end
