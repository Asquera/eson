module ElasticSearch
  module Search
    class FQuery
      include Filter
      include Queries
      include QueryMethods
      
      short_name :fquery
      
      attr_accessor :options
      
      def initialize(options = {})
        self.options = options
      end
      
      def to_query_hash
        {name => {:query => queries.to_query_hash}.merge!(options)}
      end
    end
  end
end