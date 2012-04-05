module Eson
  module Search
    class Wildcard < FieldBased
      include Query
      
      short_name :wildcard
      
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