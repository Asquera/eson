module ElasticSearch
  module Search
    module QueryGroup
      include Filters
      include Queries

      def group_to_query_hash(base = true)
        if queries && filters && queries.any? && filters.any?
          hash = {
            :filtered => {
              :query => queries.to_query_hash,
              :filter => filters.to_query_hash
            }
          }
        else
          if filters && filters.any?
            hash = filters.to_query_hash
          end

          if queries && queries.any?
            hash = queries.to_query_hash
          end
        end

        hash
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