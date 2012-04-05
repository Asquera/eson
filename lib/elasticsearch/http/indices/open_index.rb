module Eson
  module HTTP
    module OpenIndex
      include Shared::OpenIndex
      extend API
      
      request_method :post
      
      def path
        "/{-list|,|indices}/_open"
      end
    end
  end
end