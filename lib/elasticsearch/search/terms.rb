module ElasticSearch
  module Search
    class Terms
      include Query
      include Filter
      include Facet
      
      short_name :terms
      
      attr_accessor :options, :field
      
      def initialize(options = {})
        self.options = options
      end
    end
  end
end