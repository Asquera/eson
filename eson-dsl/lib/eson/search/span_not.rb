module Eson
  module Search
    class SpanNot
      include Query

      # @macro eson.query
      query :span_not

      def include(&block)
        @include ||= SubQuery.new
        @include.send(context, &block)
      end

      def exclude(&block)
        @exclude ||= SubQuery.new
        @exclude.send(context, &block)
      end

      def to_query_hash
        result = {}

        result[:include] = @include.to_query_hash
        result[:exclude] = @exclude.to_query_hash

        {name => result}
      end
    end
  end
end