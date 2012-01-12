module ElasticSearch
  module Search
    class Nested
      include Query
      include QueryGroup

      short_name :nested

      attr_accessor :options

      def initialize(options = {})
        self.options = options
        instance_exec(self, &Proc.new) if block_given?
      end

      def to_query_hash
        {
          name => options.merge({
            :query => queries.to_query_hash,
            :filter => filters.to_query_hash
          })
        }
      end
    end
  end
end
