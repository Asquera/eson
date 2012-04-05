module Eson
  module Search
    class DisMax
      include Query
      include Queries

      # @macro eson.query
      query :dis_max

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end

      def to_query_hash
        {name => {:queries => queries.to_query_hash}.merge(options) }
      end

    end
  end
end