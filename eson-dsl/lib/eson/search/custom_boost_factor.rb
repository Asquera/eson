module Eson
  module Search
    class CustomBoostFactor

      include Queries
      include Query

      # @macro eson.query
      short_name :custom_boost_factor

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end

    end
  end
end