describe Skeleton::DatabaseHandler do
    it "is an HTTP handler" do
        database_handler = Skeleton::DatabaseHandler.new;
        database_handler.methods.should contain "call";
    end
end
