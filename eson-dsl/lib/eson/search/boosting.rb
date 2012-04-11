module Eson
  module Search
    class Boosting
      include Query

      ##
      # @macro eson.query
      #   Generates a `$1` query.
      #   @method $1
      #   {include:file:examples/queries/$1.rb}
      #   @see Eson::Search::Queries
      query :boosting

      attr_accessor :options, :conditions

      def initialize(options = {})
        self.options = options
      end

      def boosts
        @boosts ||= {}
      end

      def positive(&block)
        q = (boosts[:positive] ||= SubQuery.new)
        q.query(&block)
      end

      def negative(&block)
        q = (boosts[:negative] ||= SubQuery.new)
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