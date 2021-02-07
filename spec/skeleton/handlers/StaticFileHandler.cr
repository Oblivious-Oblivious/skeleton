describe Skeleton::StaticFileHandler do
    it "is an HTTP handler" do
        static_file_handler = Skeleton::StaticFileHandler.new("./public");
        static_file_handler.methods.should contain "call";
    end
end
