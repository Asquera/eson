module Eson
  module HTTP
    module Optimize
      include Shared::Optimize
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