module ElasticSearch
  module HTTP
    module Search
      include Shared::Search
      extend API
      
      request_method :post
      
      def bare_path
        unless types.empty?
          path = "{-list|,|indices}/{-list|,|types}/"
        else
          path = "{-list|,|indices}/"
        end
      end
      
      def path
        path = bare_path + "_search"
        
        if scroll
          path << "/scroll"
        end
        
        path
      end
      
    end
  end
end