module Eson
  module Search
    class Histogram
      include Facet
      
      short_name :histogram
      
      attr_accessor :options
      
      def initialize(options = {})
        self.options = options
      end
      
      def to_query_hash
        {name => options}
      end
    end
  end
end