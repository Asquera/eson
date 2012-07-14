module Eson
  module Search
    class HasChild
      include Query
      include Filter

      include QueryGroup

      # @macro has_child
      #   Generates a `$1` filter or query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}
      short_name :has_child

      attr_accessor :options

      def initialize(type, options = {})
        self.options = options.merge(:type => type)
      end

      def to_query_hash
        {
          name => options.merge(:query => super)
        }
      end

    end
  end
end
