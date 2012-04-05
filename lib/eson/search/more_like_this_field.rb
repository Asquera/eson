module Eson
  module Search
    class MoreLikeThisField
      include Query

      # @macro eson.query
      query :mlt_field

      attr_accessor :field

      def initialize(field, options = {})
        self.field = QueryField.new(field, options)
      end

      def to_query_hash
        {name => field.to_query_hash}
      end
    end
  end
end