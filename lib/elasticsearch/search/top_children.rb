module ElasticSearch
  module Search
    class TopChildren
      include QueryGroup
      
      include Query
      include Filter
      
      short_name :top_children
      
      attr_accessor :options
      
      def initialize(type, options = {})
        self.options = options.merge(:type => type)
      end
      
      def to_query_hash
        {
          name => group_to_query_hash.merge(options)
        }
      end
      
    end
  end
end