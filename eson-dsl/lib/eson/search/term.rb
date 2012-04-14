module Eson
  module Search
    class Term < FieldBased
      include Query
      include Filter

      # @macro term
      #   Generates a `$1` filter, query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}
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