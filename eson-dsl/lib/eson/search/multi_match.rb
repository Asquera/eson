module Eson
  module Search
    class MultiMatch
      include Query

      # @macro eson.query
      short_name :multi_match

      attr_accessor :options, :query

      def initialize(query, options = {})
        self.options = options
        self.query = query
      end

      def to_query_hash
        {:multi_match => {:query => query}.merge!(options)}
      end
    end
  end
end