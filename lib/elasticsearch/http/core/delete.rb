module Eson
  module HTTP
    module Delete
      include Shared::Delete
      extend API
      
      request_method :delete
      
      def path
        "/{index}/{type}/{id}"
      end
    end
  end
end