module Eson
  module Search
    class QueryFacet
      include Facet
      include Queries
      include QueryMethods

      # @macro eson.facet
      facet :query

      def to_query_hash
        {:query => queries.to_query_hash}
      end
    end
  end
end