module Eson
  module HTTP
    module Snapshot
      include Shared::Snapshot
      extend API
      
      request_method :post
          
      def path
        unless indices.empty?
          "/{indices}/_gateway/snapshot"
        else
          "/_gateway/snapshot"
        end
      end
    end
  end
end