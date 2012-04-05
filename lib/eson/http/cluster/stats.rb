module Eson
  module HTTP
    module Stats
      include Shared::Stats
      extend API
      
      request_method :get
    
      def path
        if nodes.empty?
          '/_cluster/nodes/stats'
        else
          '/_cluster/nodes/{-list|,|nodes}/stats'
        end
      end
    end
  end
end