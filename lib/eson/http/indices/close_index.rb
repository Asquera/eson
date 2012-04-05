module Eson
  module HTTP
    module CloseIndex
      include Shared::CloseIndex
      extend API
      
      request_method :post
      
      def path
        "/{-list|,|indices}/_close"
      end
    end
  end
end