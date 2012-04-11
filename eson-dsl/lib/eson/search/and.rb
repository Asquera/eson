module Eson
  module Search
    class And
      include Filters
      include FilterMethods
      include Filter

      ##
      # @macro eson.filter
      #   Generates a `$1` filter.
      #   @method $1
      #   {include:file:examples/filters/$1.rb}
      #   @see Eson::Search::Filters
      filter 'and'

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