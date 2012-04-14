module Eson
  module Search
    class And
      include Filters
      include FilterMethods
      include Filter

      ##
      # @macro and
      #   @yield the block describing all subfilters 
      #   Generates a `$1` filter.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      short_name 'and'

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end

      def to_query_hash
        { name => filters.to_query_hash }
      end

    end
  end
end