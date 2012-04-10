module Eson
  module Search
    class Nested
      include Query
      include QueryGroup

      # @macro eson.query
      query :nested

      attr_accessor :options

      def initialize(options = {})
        self.options = options
        instance_exec(self, &Proc.new) if block_given?
      end

      def to_query_hash
        {
          name => {:query => super}.merge(options)
        }
      end
    end
  end
end
