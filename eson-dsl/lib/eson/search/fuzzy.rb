module Eson
  module Search
    class Fuzzy
      include Query

      # @macro eson.query
      short_name :fuzzy

      attr_accessor :field
      attr_accessor :options

      def initialize(*args)
        if args.length == 1
          self.options = args.first
        else
          self.field = QueryField.new(*args)
        end
      end

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