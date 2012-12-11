module Eson
  module HTTP
    module PutMapping
      include Shared::PutMapping
      extend API
      
      request_method :put
      
      def path
        if type && !indices.empty?
          "/{indices}/{type}/_mapping"
        end
      end
    end
  end
end