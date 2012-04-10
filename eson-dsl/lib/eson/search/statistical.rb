module Eson
  module Search
    class Statistical
      include Facet

      # @macro eson.facet
      facet :statistical

      attr_accessor :options

      def initialize(options)
        self.options = options
      end

      def to_query_hash
        {name => options}
      end
    end
  end
end