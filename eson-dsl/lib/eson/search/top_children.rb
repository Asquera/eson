module Eson
  module Search
    class TopChildren
      include Query
      include Filter
      include QueryGroup

      # @macro top_children
      #   Generates a `$1` filter, query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}# @macro eson.query
      short_name :top_children

      attr_accessor :options

      def initialize(type, options = {})
        self.options = options.merge(:type => type)
      end

      def to_query_hash
        {
          name => {:query => super}.merge(options)
        }
      end

    end
  end
end