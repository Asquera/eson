module ElasticSearch
  module Search
    class ConstantScore
      
      include Filters
      include Queries
      
      include Filter
      include Query
      
      short_name :constant_score
      
      attr_accessor :options
      
      def initialize(options = {})
        self.options = options
      end
      
    end
  end
end