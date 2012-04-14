module Eson
  module Search
    class Range
      include Query
      include Filter
      include Facet

      # @macro range
      #   Generates a `$1` filter, facet or  query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/facet/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}
      short_name :range

      attr_accessor :field

      def initialize(field, *options)
        self.field = QueryField.new(field, *options)
      end

      def to_query_hash
        {name => field.to_query_hash}
      end
    end
  end
end