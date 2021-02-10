describe Skeleton::NullHandler do
    it "is an HTTP handler" do
        fileio_handler = Skeleton::NullHandler.new;
        fileio_handler.responds_to?(:call).should eq true;
    end
end
