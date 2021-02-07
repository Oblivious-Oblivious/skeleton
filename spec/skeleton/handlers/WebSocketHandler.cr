describe Skeleton::WebSocketHandler do
    it "is an HTTP handler" do
        websocket_handler = Skeleton::WebSocketHandler.new { |ws, context| ; };
        websocket_handler.methods.should contain "call";
    end
end
