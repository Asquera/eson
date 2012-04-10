module Eson
  module Search
    class Type
      include Filter

      # @macro eson.filter
      filter :type

      attr_accessor :type

      def initialize(type)
        self.type = type
      end

      def to_query_hash
        {:type => {:value => type}}
      end
    end
  end
end