module ElasticSearch
  module Search
    class SpanTerm < FieldBased
      include Query

      short_name :span_term

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
