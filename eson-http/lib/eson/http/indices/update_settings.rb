module Eson
  module HTTP
    module UpdateSettings
      include Shared::UpdateSettings
      extend API
      
      request_method :put
      
      def path
        unless indices.empty?
          "/{indices}/_settings"
        else
          "/_settings"
        end
      end 
    end
  end
end