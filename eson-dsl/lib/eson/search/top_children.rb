module Eson
  module Search
    class TopChildren
      include Query
      include Filter
      include QueryGroup

      # @macro eson.filter
      # @macro eson.query
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