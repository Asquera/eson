module Eson
  module Search
    class Bool
      include Filter
      include Query
      
      # @macro bool
      #   @yield the block containing all subqueries
      #   Generates a `$1` filter or query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}
      short_name :bool

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