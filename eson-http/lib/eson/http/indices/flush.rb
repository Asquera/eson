module Eson
  module HTTP
    module Flush
      include Shared::Flush
      extend API
      
      request_method :post
            
      def path
        unless indices.empty?
          "/{indices}/_flush"
        else
          "/_flush"
        end
      end
    end
  end
end