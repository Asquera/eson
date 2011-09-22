module ElasticSearch
  module HTTP
    module Health
      include Shared::Health
      extend API
      
      request_method :get
             
      def path
        '/_cluster/health/{-list|,|indices}'
      end
      
    end
  end
end