module ElasticSearch
  module HTTP
    module GetTemplate
      include Shared::GetTemplate
      extend API
      
      request_method :get
      
      def path
        "/_template/{name}"
      end
    end
  end
end