module ElasticSearch
  module HTTP
    module SimpleSearch
      extend API
      
      request_method :get

      parameters :timeout, 
                 :type, 
                 :q,
                 :routing,
                 :df,
                 :analyzer,
                 :fields,
                 :sort,
                 :track_scores,
                 :timeout,
                 :from,
                 :size,
                 :search_type
      
      def path
        unless types.empty?
          "{-list|,|indices}/{-list|,|types}/_search"
        else
          "{-list|,|indices}/_search"
        end
      end
    end
  end
end