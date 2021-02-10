describe Skeleton::StaticFileHandler do
    it "is an HTTP handler" do
        static_file_handler = Skeleton::StaticFileHandler.new("./public");
        static_file_handler.responds_to?(:call).should eq true;
    end
end
