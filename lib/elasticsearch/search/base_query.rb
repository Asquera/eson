module ElasticSearch
  module Search
    class BaseQuery
      include QueryGroup
      include Facets

      def group_to_query_hash(base = true)
        if (!queries || queries.empty?)
          hash = {:query => {:match_all => {}}}
        else
          hash = {:query => queries.to_query_hash }
        end

        if filters && !filters.empty?
          hash = {
            :query => {
              :filtered => {
                :query => hash[:query],
                :filter => filters.to_query_hash
              }
            }
          }
        end

        if facets.length > 0
          hash[:facets] = facets.to_query_hash
        end

        hash
      end
    end
  end
end