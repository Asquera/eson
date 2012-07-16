module Eson
  module Search
    class Terms
      include Query
      include Filter
      include Facet

      # @macro eson.filter
      # @macro eson.query
      # @macro eson.facet
      short_name :terms

      attr_accessor :options, :field

      def initialize(options = {})
        self.options = options
      end
    end
  end
end