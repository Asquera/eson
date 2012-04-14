module Eson
  module Search
    class Ids
      include Filter
      include Query

      # @macro ids
      #   Generates a `$1` filter or query, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/queries/$1.rb}
      short_name :ids

      attr_accessor :options

      def initialize(*args)
        if args.length == 2
          self.options = {
            :type => args.first,
            :values => args.last
          }
        else
          self.options = args.first
        end
      end
    end
  end
end