module ElasticSearch
  module HTTP
    module Shutdown
      #TODO fully implement and test this
      include Shared::Shutdown
      extend API
      
      request_method :post
      
      def path
        '/_cluster/nodes/{-list|,|nodes}/_shutdown'
      end
    end
  end
end