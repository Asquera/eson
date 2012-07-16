module Eson
  module Search
    class And
      include Filters
      include FilterMethods
      include Filter

      # @!macro eson.filter
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