describe Skeleton::DatabaseHandler do
    it "is an HTTP handler" do
        database_handler = Skeleton::DatabaseHandler.new;
        database_handler.responds_to?(:call).should eq true;
    end
end
