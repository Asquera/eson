module Eson
  module Search
    class Terms
      include Query
      include Filter
      include Facet

      # @macro terms
      #   Generates a `$1` filter, facet or  query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/facet/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}
      short_name :terms

      attr_accessor :options, :field

      def initialize(options = {})
        self.options = options
      end
    end
  end
end