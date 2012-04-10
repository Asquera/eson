module Eson
  module Search
    class FQuery
      include Filter
      include Queries
      include QueryMethods

      # @macro eson.filter
      filter :fquery

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end

      def to_query_hash
        {name => {:query => queries.to_query_hash}.merge!(options)}
      end
    end
  end
end