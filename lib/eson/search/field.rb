module Eson
  module Search
    class Field
      include Query

      query :field

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end
    end
  end
end