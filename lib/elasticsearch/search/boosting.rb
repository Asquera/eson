module ElasticSearch
  module Search
    class Boosting
      include Query
      
      short_name :boosting
      
      attr_accessor :options, :conditions
      
      def initialize(options = {})
        self.options = options
      end
      
      def boosts
        @boosts ||= {}
      end
      
      def positive(&block)
        q = (boosts[:positive] ||= SubQuery.new)
        q.query(&block)
      end
      
      def negative(&block)
        q = (boosts[:negative] ||= SubQuery.new)
        q.query(&block)
      end
      
      def to_query_hash
        result = {}
        
        boosts.each do |k,v|
          result[k] = v.to_query_hash
        end
        
        {name => result.merge(options)}
      end
      
    end
  end
end