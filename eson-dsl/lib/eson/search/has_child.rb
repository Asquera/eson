module Eson
  module Search
    class HasChild
      include Query
      include Filter

      include QueryGroup

      # @macro eson.filter
      filter :has_child

      # @macro eson.query
      query :has_child

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