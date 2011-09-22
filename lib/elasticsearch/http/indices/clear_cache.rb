module ElasticSearch
  module HTTP
    module ClearCache
      include Shared::ClearCache
      extend API
      
      request_method :post
      
      def path
        if index
          "/{-list|,|indices}/_cache/clear"
        else
          "/_cache/clear"
        end
      end
    end
  end
end