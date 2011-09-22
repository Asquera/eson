module ElasticSearch
  module Search
    module QueryGroup
      include Filters
      include Queries
      include Facets
      
      def group_to_query_hash(base = true)
        if filters.empty? && facets.empty?
          hash = queries.to_query_hash
        elsif !queries && !filters.empty?          
          if base
            hash = { 
                     :filtered => {
                       :query => {:match_all => {}},
                       :filter => filters.to_query_hash
                     }
                   }
          else
            hash = filters.to_query_hash
                    
                   
          end
        elsif queries.length > 0 && filters.length > 0
          hash = {
                   :filtered => {
                     :query => queries.to_query_hash,
                     :filter => filters.to_query_hash
                   }
                 }
        elsif queries.length > 0 && facets.length > 0
          base = false
          hash = {
            :query => queries.to_query_hash,
            :facets => facets.to_query_hash
          }
        end
        
        
        base ? {:query => hash} : hash
      end
      
      def to_query_hash(base = true)
        group_to_query_hash(base)
      end
      
      def to_hash
        to_query_hash
      end
    end
  end
end