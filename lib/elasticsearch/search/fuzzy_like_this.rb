module ElasticSearch
  module Search
    class FuzzyLikeThis
      include Query
      
      short_name :flt
      
      attr_accessor :options
      
      def initialize(options = {})
        self.options = options
      end
    end
  end
end