module Eson
  module Search
    class TermsStats
      include Facet

      # @macro eson.facet
      short_name :terms_stats

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