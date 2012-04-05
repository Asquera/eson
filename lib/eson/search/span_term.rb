module Eson
  module Search
    class SpanTerm < FieldBased
      include Query

      # @macro eson.query
      query :span_term

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
