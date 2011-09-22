module ElasticSearch
  module HTTP
    module PutTemplate
      include Shared::PutTemplate
      extend API
      
      request_method :put
      
      def path
        "/_template/{name}"
      end
    end
  end
end