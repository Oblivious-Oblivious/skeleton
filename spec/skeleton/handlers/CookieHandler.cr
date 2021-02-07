describe Skeleton::CookieHandler do
    it "is an HTTP handler" do
        cookie_handler = Skeleton::CookieHandler.new;
        cookie_handler.methods.should contain "call";
    end
end
