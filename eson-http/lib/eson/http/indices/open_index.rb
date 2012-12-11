module Eson
  module HTTP
    module OpenIndex
      include Shared::OpenIndex
      extend API
      
      request_method :post
      
      def path
        "/{indices}/_open"
      end
    end
  end
end