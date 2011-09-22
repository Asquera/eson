module ElasticSearch
  module HTTP
    module GetSettings
      include Shared::GetSettings
      extend API
      
      request_method :get
      
      def path
        if index
          "/{-list|,|indices}/_settings"
        else
          "/_settings"
        end
      end
    end
  end
end