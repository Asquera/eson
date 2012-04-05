module Eson
  module Search
    class Term < FieldBased
      include Query
      include Filter

      short_name :term

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