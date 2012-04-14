module Eson
  module Search
    class Prefix < FieldBased
      include Query
      include Filter

      # @macro prefix
      #   Generates a `$1` filter or query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}
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