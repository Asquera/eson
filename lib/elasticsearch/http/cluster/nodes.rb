module Eson
  module HTTP
    module Nodes
      include Shared::Nodes
      extend API
      
      request_method :get
    
      def path
        '/_cluster/nodes/{-list|,|nodes}'
      end
    end
  end
end