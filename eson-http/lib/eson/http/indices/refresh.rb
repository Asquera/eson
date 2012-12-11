module Eson
  module HTTP
    module Refresh
      include Shared::Refresh
      extend API
      
      request_method :post
      
      def path
        if index
          "/{indices}/_refresh"
        else
          "/_refresh"
        end
      end
    end
  end
end