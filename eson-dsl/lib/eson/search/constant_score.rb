module Eson
  module Search
    class ConstantScore

      include Filters
      include Queries

      include Query

      ##
      # @macro eson.query
      query :constant_score

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end

    end
  end
end