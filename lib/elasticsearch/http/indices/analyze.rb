module ElasticSearch
  module HTTP
    module Analyze
      include Shared::Analyze
      extend API
      
      request_method :put
            
      def path        
        '/{index}/_analyze'
      end
    end
  end
end