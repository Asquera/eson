module Eson
  module Search
    class MoreLikeThis
      include Query

      # @macro eson.query
      short_name :mlt

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end
    end
  end
end