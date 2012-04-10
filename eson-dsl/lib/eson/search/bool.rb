module Eson
  module Search
    class Bool
      include Filter
      include Query

      # @macro eson.filter
      filter :bool

      # @macro eson.query
      query :bool

      attr_accessor :options, :conditions

      def initialize(options = {})
        self.options = options
      end

      def conditions
        @conditions ||= {}
      end

      def must(&block)
        q = (conditions[:must] ||= SubQuery.new)
        q.send(context, &block)
      end

      def must_not(&block)
        q = (conditions[:must_not] ||= SubQuery.new)
        q.send(context, &block)
      end

      def should(&block)
        q = (conditions[:should] ||= SubQuery.new)
        q.send(context, &block)
      end

      def to_query_hash
        result = {}

        conditions.each do |k,v|
          result[k] = v.to_query_hash
        end

        {name => result.merge(options)}
      end

    end
  end
end