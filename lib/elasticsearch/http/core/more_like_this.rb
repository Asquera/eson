module ElasticSearch
  module HTTP
    module MoreLikeThis
      include Search
      extend API
      
      request_method :get
      parameters :type, :id
      
      def path
        "{-list|,|indices}/{type}/{id}/_mlt"
      end
    end
  end
end