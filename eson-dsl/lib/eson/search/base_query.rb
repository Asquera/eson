module Eson
  module Search
    class BaseQuery
      include QueryGroup
      include Facets
      include Parametrized
      
      def initialize(args = {})
        self.args = args
        instance_exec(self, &Proc.new) if block_given?
      end

      def to_query_hash
        if (!queries || queries.empty?)
          hash = {:query => {:match_all => {}}}
        else
          hash = {:query => queries.to_query_hash }
        end

        if filters && !filters.empty?
          if filters.length > 1
            hash[:filter] = {:and => filter.to_query_hash}
          else
            hash[:filter] = filter.to_query_hash
          end
        end

        if facets.length > 0
          hash[:facets] = facets.to_query_hash
        end

        hash
      end
    end
  end
end