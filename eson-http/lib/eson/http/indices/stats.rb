module Eson
  module HTTP
    module IndexStats
      include Shared::IndexStats
      extend API
      
      request_method :get
          
      def path
        unless indices.empty?
          "/{indices}/_stats"
        else
          "/_stats"
        end
      end
    end
  end
end