module Eson
  module Search
    class Prefix < FieldBased
      include Query
      include Filter

      # @macro eson.query
      query :prefix

      # @macro eson.filter
      filter :prefix

      def to_query_hash
        if field
          {name => field.to_query_hash}
        else
          {name => options}
        end
      end
    end
  end
end