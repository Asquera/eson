module Eson
  module Search
    class Boosting
      include Query

      ##
      # @macro eson.query
      #   @yield the block describing all subqueries 
      #   Generates a `$1` query.
      #   {include:file:eson-dsl/examples/queries/$1.rb}
      short_name :boosting

      attr_accessor :options, :conditions

      def initialize(options = {})
        self.options = options
      end

      def boosts
        @boosts ||= {}
      end

      def positive(&block)
        q = (boosts[:positive] ||= SubQuery.new(args))
        q.query(&block)
      end

      def negative(&block)
        q = (boosts[:negative] ||= SubQuery.new(args))
        q.query(&block)
      end

      def to_query_hash
        result = {}

        boosts.each do |k,v|
          result[k] = v.to_query_hash
        end

        {name => result.merge(options)}
      end

    end
  end
end