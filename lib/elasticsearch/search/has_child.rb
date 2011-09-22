module ElasticSearch
  module Search
    class HasChild
      include QueryGroup
      
      include Query
      include Filter
      
      short_name :has_child
      
      attr_accessor :options
      
      def initialize(type, options = {})
        self.options = options.merge(:type => type)
      end
      
      def to_query_hash
        {
          name => options.merge(:query => group_to_query_hash(false))
        }
      end
      
    end
  end
end