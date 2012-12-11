module Eson
  module HTTP
    module Health
      include Shared::Health
      extend API
      
      request_method :get
             
      def path
        '/_cluster/health/{indices}'
      end
      
    end
  end
end