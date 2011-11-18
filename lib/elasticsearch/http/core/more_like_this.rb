module ElasticSearch
  module HTTP
    module MoreLikeThis
      include Shared::MoreLikeThis
      extend API
      
      request_method :get
      
      def path
        "{-list|,|indices}/{type}/{id}/_mlt"
      end
    end
  end
end