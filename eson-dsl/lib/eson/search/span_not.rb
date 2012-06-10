module Eson
  module Search
    class SpanNot
      include Query

      # @macro eson.query
      short_name :span_not

      def include(&block)
        @include ||= SubQuery.new(args)
        @include.send(context, &block)
      end

      def exclude(&block)
        @exclude ||= SubQuery.new(args)
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