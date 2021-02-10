describe Skeleton::CookieHandler do
    it "is an HTTP handler" do
        cookie_handler = Skeleton::CookieHandler.new;
        cookie_handler.responds_to?(:call).should eq true;
    end
end
