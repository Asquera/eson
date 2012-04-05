module Eson
  module Search
    class Prefix < FieldBased
      include Query
      include Filter
      
      short_name :prefix
      
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