module ElasticSearch
  module Search
    class Exists < FieldBased
      include Filter
      
      short_name :exists
      
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