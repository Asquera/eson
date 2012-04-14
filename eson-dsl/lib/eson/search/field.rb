module Eson
  module Search
    class Field
      include Query

      # @macro eson.query
      short_name :field

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end
    end
  end
end