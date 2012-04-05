module Eson
  module Search
    class Terms
      include Query
      include Filter
      include Facet

      # @macro eson.query
      query :terms

      # @macro eson.filter
      filter :terms

      # @macro eson.facet
      facet :terms

      attr_accessor :options, :field

      def initialize(options = {})
        self.options = options
      end
    end
  end
end