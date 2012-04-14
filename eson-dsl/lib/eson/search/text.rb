module Eson
  module Search
    class Text
      #TODO: implement alternative forms like:
      # {
      #    "text_phrase" : {
      #        "message" : "this is a test"
      #    }
      #}
      include Query

      # @macro eson.query
      short_name :text

      attr_accessor :options

      def initialize(options = {})
        self.options = options
      end

    end
  end
end