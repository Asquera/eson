module ElasticSearch
  module Search
    class Field
      include Query
      
      short_name :field
      
      attr_accessor :options
      
      def initialize(options = {})
        self.options = options
      end
    end
  end
end